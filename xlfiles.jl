using Dates, XLSX, DataFrames
df = DataFrames.DataFrame(integers=[1, 2, 3, 4], strings=["Hey", "You", "Out", "There"], floats=[10.2, 20.3, 30.4, 40.5], dates=[Date(2018,2,20), Date(2018,2,21), Date(2018,2,22), Date(2018,2,23)], times=[Dates.Time(19,10), Dates.Time(19,20), Dates.Time(19,30), Dates.Time(19,40)], datetimes=[Dates.DateTime(2018,5,20,19,10), Dates.DateTime(2018,5,20,19,20), Dates.DateTime(2018,5,20,19,30), Dates.DateTime(2018,5,20,19,40)])   
XLSX.writetable("output_table.xlsx", df, overwrite=true, sheetname="report", anchor_cell="B2")
f = XLSX.readxlsx("output_table.xlsx")
s = f["report"]
XLSX.eachtablerow(s) |> DataFrames.DataFrame

xl_path = "/Users/danielrizk/Downloads/Assignment_Datasets/import.xlsx"

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

function read_excel(
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
    xf = XLSX.readxlsx(path)

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

read_excel(xl_path)


function write_xlsx(x; path::String, col_names::Bool=true)
    # Preparing data for writing based on input type
    if typeof(x) <: DataFrames.DataFrame
        # Single DataFrame provided
        data_to_write = Dict("Sheet1" => x)
    elseif typeof(x) <: Dict{String, DataFrames.DataFrame}
        # A Dict of DataFrames provided
        data_to_write = x
    else
        throw(ArgumentError("Input must be a DataFrame or a Dict of DataFrames"))
    end

    # Converting DataFrames to the format expected by XLSX.writetable
    tables_to_write = [sheet_name => (collect(eachcol(df)), names(df)) for (sheet_name, df) in data_to_write]

    # Writing to XLSX file
    XLSX.writetable(path, tables_to_write...)
end
df1 = DataFrames.DataFrame(COL1=[10,20,30], COL2=["First", "Second", "Third"])
df2 = DataFrames.DataFrame(AA=["aa", "bb"], AB=[10.1, 10.2])

# Use a Dict to associate each DataFrame with a sheet name
sheets = Dict("REPORT_A" => df1, "REPORT_B" => df2)
write_xlsx(("REPORT_A" => df1, "REPORT_B" => df2, "s3" => mtcarsastsv); path="/Users/danielrizk/Downloads/report.xlsx", overwrite = true)
read_excel("/Users/danielrizk/Downloads/report.xlsx", sheet = "s3", skip = 3, n_max = 4, missingstring = ["Hornet Sportabout", 3])
write_xlsx("REPORT_A" => df1; path="multi_sheet_report.xlsx")

XLSX.writetable("/Users/danielrizk/Downloads/report.xlsx", sheets)


XLSX.writetable("/Users/danielrizk/Downloads/report.xlsx", "REPORT_A" => df1, "REPORT_B" => df2)



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
