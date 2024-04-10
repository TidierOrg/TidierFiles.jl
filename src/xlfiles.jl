function infer_type(value)
    if isa(value, Missing)
        return Missing
    elseif isa(value, Number)
        if isa(value, Int) || isa(value, Bool)
            return Int
        else
            return Float64
        end
    elseif isa(value, DateTime)
        return DateTime
    elseif isa(value, Time)
        return Time
    elseif isa(value, Date)
        return Date
    else
        return String
    end
end

function convert_column(column)
    non_missing_values = filter(!ismissing, column)
    if isempty(non_missing_values)
        return column  # Return as-is if all values are missing
    end

    target_type = reduce((x, y) -> x === y ? x : String, map(infer_type, non_missing_values))
    try
        return target_type == Missing ? column : convert(Vector{target_type}, column)
    catch
        return column  # Fallback to original if conversion fails
    end
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

"""
$docstring_read_xlsx
"""
function read_xlsx(
    path;
    sheet = nothing,
    range = nothing,
    col_names = true,
    col_types = nothing,
    missingstring = "",
    trim_ws = true,
    skip = 0,
    n_max = Inf,
    guess_max = nothing)

    
    if startswith(path, "http://") || startswith(path, "https://")
        # Fetch the content from the URL
        response = HTTP.get(path)

        # Ensure the request was successful
        if response.status != 200
            error("Failed to fetch the Excel file: HTTP status code ", response.status)
        end

        # Read the Excel data from the fetched content
        xf = XLSX.readxlsx(IOBuffer(response.body))
    else
        # Read from a local file
        xf = XLSX.readxlsx(path)
    end
    # Determine the sheet to read from
    sheet_to_read = isnothing(sheet) ? first(XLSX.sheetnames(xf)) : sheet

    # Read the specified range or the entire sheet if range is not specified
    if isnothing(range)
        data = XLSX.eachtablerow(xf[sheet_to_read]) |> DataFrame
    else
        data = XLSX.readdata(path, sheet_to_read, range) |> DataFrame
    end

    # Initial column name processing
    if col_names == true && !isnothing(range)
        col_names_row = XLSX.readdata(path, sheet_to_read, replace(range, r"[0-9]+:[0-9]+$" => "1:1"))[1, :]
        rename!(data, Symbol.(col_names_row))
        data = data[2:end, :]
    elseif col_names != true && col_names != false
        rename!(data, Symbol.(col_names))
    elseif col_names == false
        rename!(data, Symbol.(:auto))
    end

    # Skipping rows
    if skip > 0
        data = data[(skip+1):end, :]
    end

    # Limiting number of rows
    if !isinf(n_max)
        data = data[1:min(n_max, nrow(data)), :]
    end

    if !isempty(missingstring)
        for missing_value in missingstring
            for col in names(data)
                # Apply replacement on the entire column for each missing string value
                data[!, col] = replace(data[!, col], missing_value => missing)
            end
        end
    end

    # Trim whitespace
    if trim_ws
        for col in names(data)
            if eltype(data[!, col]) == String
                data[!, col] = strip.(data[!, col])
            end
        end
    end

    # Automatic type conversion based on inferred types
    for col in names(data)
        data[!, col] = convert_column(data[!, col])
    end

    return data
end