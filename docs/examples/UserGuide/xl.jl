# Reading and writing XLSX files are made possible by XLSX.jl

# ## `read_xlsx`
# read_xlsx(path; sheet=nothing, range=nothing, col_names=true, col_types=nothing, missingstring="", trim_ws=true, skip=0, n_max=Inf, guess_max=nothing)

# This function reads data from an Excel file into a DataFrame. The arguments are:

# - `path`: The path or URL to the Excel file to be read.
# - `sheet`: The sheet to be read. Can be a sheet name (string) or index (integer). Default is the first sheet.
# - `range`: A specific range of cells to be read from the sheet. Default is the entire sheet.
# - `col_names`: Whether the first row of the range contains column names. Default is `true`.
# - `col_types`: Explicit specification of column types. Can be a single type, a list, or a dictionary mapping column names or indices to types. Default is `nothing` (types are inferred).
# - `missingstring`: The string representing missing values. Default is `""`.
# - `trim_ws`: Whether to trim leading and trailing whitespace from cells. Default is `true`.
# - `skip`: Number of rows to skip before reading data. Default is 0.
# - `n_max`: Maximum number of rows to read. Default is `Inf` (read all rows).
# - `guess_max`: Maximum number of rows to scan for type guessing and column names detection. Default is `nothing` (a default heuristic is used).

# ## `write_xlsx`
# write_xlsx(x; path, overwrite=false)

# This function writes a DataFrame, or multiple DataFrames, to an Excel file. The arguments are:

# - `x`: The data to write. Can be a single `Pair{String, DataFrame}` for writing one sheet, or a `Tuple` of such pairs for writing multiple sheets. The `String` in each pair specifies the sheet name, and the `DataFrame` is the data to write to that sheet.
# - `path`: The path to the output Excel file.
# - `overwrite`: Whether to overwrite an existing file. Default is `false`.