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
        return [x === missing ? missing : isa(x, Int) ? x : tryparse(Int, string(x)) for x in col]
    elseif inferred_type == Float64
        return [x === missing ? missing : isa(x, Float64) ? x : tryparse(Float64, string(x)) for x in col]
    elseif inferred_type == Date
        return [x === missing ? missing : isa(x, Date) ? x : tryparse(Date, string(x), dateformat"yyyy-mm-dd") for x in col]
    else
        return [x === missing ? missing : convert(String, x) for x in col]
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
    n_max = Inf
)
    # Fetch the Excel file (from URL or local path)
    xf = if startswith(path, "http://") || startswith(path, "https://")
        response = HTTP.get(path)
        if response.status != 200
            error("Failed to fetch the Excel file: HTTP status code ", response.status)
        end
        XLSX.readxlsx(IOBuffer(response.body))
    else
        XLSX.readxlsx(path)
    end

    # Determine which sheet to read
    sheet_to_read = isnothing(sheet) ? first(XLSX.sheetnames(xf)) : sheet

    # Read the table data from the specified range or full sheet
    table_data = XLSX.gettable(xf[sheet_to_read])
    data = DataFrame(table_data)

    # Infer and apply column types based on the first 5 rows
    for col in names(data)
        col_values = data[!, col]
        inferred_type = infer_column_type(col_values)
        data[!, col] = convert_column(col_values, inferred_type)
    end

    # Skipping rows
    if skip > 0
        data = data[(skip+1):end, :]
    end

    # Limiting the number of rows
    if !isinf(n_max)
        data = data[1:min(n_max, nrow(data)), :]
    end

    # Replace missing strings with `missing` if applicable
    if !isempty(missing_value)
        for missing_value in missing_value
            for col in names(data)
                data[!, col] = replace(data[!, col], missing_value => missing)
            end
        end
    end

    # Trim whitespace if requested
    if trim_ws
        for col in names(data)
            if eltype(data[!, col]) == String
                data[!, col] = strip.(data[!, col])
            end
        end
    end

    return data
end

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