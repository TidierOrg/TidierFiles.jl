function infer_column_type(values)
    nonmissing_values = filter(x -> x !== missing, values)
    first_values = nonmissing_values[1:min(5, length(nonmissing_values))]

    # Check if all values are already integers
    if all(x -> isa(x, Int), first_values)
        return Int
    # Check if all values are already floats
    elseif all(x -> isa(x, Float64), first_values)
        return Float64
    # Check if all values are integers or can be parsed as integers
    elseif all(x -> isa(x, Int) || tryparse(Int, string(x)) !== nothing, first_values)
        return Int
    # Check if all values are floats or can be parsed as floats
    elseif all(x -> isa(x, Float64) || tryparse(Float64, string(x)) !== nothing, first_values)
        return Float64
    # Check if all values are dates or can be parsed as dates
    elseif all(x -> isa(x, Date) || tryparse(Date, string(x), dateformat"yyyy-mm-dd") !== nothing, first_values)
        return Date
    # Default to String
    else
        return String
    end
end

# Function to convert a column to the inferred type
# Function to convert a column to the inferred type
function convert_column(col, inferred_type)
    if inferred_type == Int
        return [x === missing ? missing :
                isa(x, Int) ? x :
                tryparse(Int, string(x)) for x in col]
    elseif inferred_type == Float64
        return [x === missing ? missing :
                isa(x, Float64) ? x :
                tryparse(Float64, string(x)) for x in col]
    elseif inferred_type == Date
        return [x === missing ? missing :
                isa(x, Date) ? x :
                tryparse(Date, string(x), dateformat"yyyy-mm-dd") for x in col]
    elseif inferred_type == String
        return [x === missing ? missing : string(x) for x in col]
    else
        return [x === missing ? missing : convert(inferred_type, x) for x in col]
    end
end



"""
$docstring_read_xlsx
"""
function read_xlsx(
    path;
    sheet = nothing,
    range = nothing,
    col_names = true,
    missing_value = "",
    trim_ws = true,
    skip = 0,
    n_max = Inf,
    col_types = Dict{Any,Any}()  # accepts Symbol | String | Int keys, flexible values
)
    xf = if startswith(path, "http://") || startswith(path, "https://")
        response = HTTP.get(path)
        if response.status != 200
            error("Failed to fetch the Excel file: HTTP status code ", response.status)
        end
        XLSX.readxlsx(IOBuffer(response.body))
    else
        XLSX.readxlsx(path)
    end

    sheet_to_read = isnothing(sheet) ? first(XLSX.sheetnames(xf)) : sheet
    table_data = XLSX.gettable(xf[sheet_to_read])
    data = DataFrame(table_data)

    # Build a lookup from normalized header -> actual name
    name_map = Dict(normalize_name(n) => n for n in names(data))

    # Preprocess user-specified overrides:
    # - Int key -> positional column
    # - Symbol/String key -> match case/whitespace-insensitively
    overrides = Dict{Any,Type}()
    for (k, v) in col_types
        tgt_type = resolve_type(v)
        if k isa Integer
            1 <= k <= ncol(data) || error("col_types position $(k) is out of bounds (ncol=$(ncol(data)))")
            overrides[names(data)[k]] = tgt_type
        else
            nk = normalize_name(k)
            if haskey(name_map, nk)
                overrides[name_map[nk]] = tgt_type
            else
                @warn "col_types key $(k) did not match any column header" available_headers=names(data)
            end
        end
    end

    # Infer/apply column types; overrides take precedence
    for col in names(data)
        col_values = data[!, col]
        requested = get(overrides, col, nothing)
        inferred_type = isnothing(requested) ? infer_column_type(col_values) : requested
        data[!, col] = convert_column(col_values, inferred_type)
    end

    if skip > 0
        data = data[(skip+1):end, :]
    end

    if !isinf(n_max)
        data = data[1:min(n_max, nrow(data)), :]
    end

    if !isempty(missing_value)
        if missing_value isa AbstractVector
            for mv in missing_value
                for col in names(data)
                    data[!, col] = replace(data[!, col], mv => missing)
                end
            end
        else
            for col in names(data)
                data[!, col] = replace(data[!, col], missing_value => missing)
            end
        end
    end

    if trim_ws
        for col in names(data)
            if eltype(data[!, col]) == String
                data[!, col] = strip.(data[!, col])
            end
        end
    end

    return data
end

resolve_type(t) = t isa Type ? t :
                  t === string ? String :
                  t === Symbol("string") ? String :
                  t === :string ? String :
                  t === :int ? Int :
                  t === :float ? Float64 :
                  t === :date ? Date :
                  t

# Normalize a column name for matching
normalize_name(x) = lowercase(strip(String(x)))


"""
$docstring_write_xlsx
"""
function write_xlsx(x; path::String, overwrite::Bool=false)
    # Handling a single DataFrame input
    if x isa Pair{String, DataFrame}
        # Single sheet: Convert the single DataFrame to the required structure
        XLSX.writetable(path, x, overwrite=overwrite)
    elseif x isa Tuple
        # Multiple sheets: Unpack the tuple of pairs directly to XLSX.writetable
        XLSX.writetable(path, x..., overwrite=overwrite)
    else
        error("Input must be a Pair of a sheet name and a DataFrame or a Tuple of such Pairs for multiple sheets.")
    end
end