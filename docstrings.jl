"""
    read_csv(file; delim=',',col_names=true, skip=0, n_max=Inf, 
        comment=nothing, missingstring="", escape_double=true, col_types=nothing)

Reads a CSV file or URL into a DataFrame, with options to specify delimiter, column names, and other CSV parsing options.

# Arguments
`file`: Path to the CSV file or a URL to a CSV file.
`delim`: The character delimiting fields in the file. Default is ','.
`col_names`: Indicates if the first row of the CSV is used as column names. Can be true, false, or an array of strings. Default is true.
`skip`: Number of initial lines to skip before reading data. Default is 0.
`n_max`: Maximum number of rows to read. Default is Inf (read all rows).
`comment`: Character that starts a comment line. Lines beginning with this character are ignored. Default is nothing (no comment lines).
`missingstring`: String that represents missing values in the CSV. Default is "", can be set to a vector of multiple items.
`escape_double`: Indicates whether to interpret two consecutive quote characters as a single quote in the data. Default is true.
`col_types`: An optional specification of column types, can be a single type applied to all columns, or a collection of types with one for each column. Default is nothing (types are inferred).

# Examples
```jldoctest 


```
"""

"""
    read_tsv(file; delim='\t',col_names=true, skip=0, n_max=Inf, 
        comment=nothing, missingstring="", escape_double=true, col_types=nothing)

Reads a TSV file or URL into a DataFrame, with options to specify delimiter, column names, and other CSV parsing options.

# Arguments
`file`: Path to the CSV file or a URL to a CSV file.
`delim`: The character delimiting fields in the file. Default is ','.
`col_names`: Indicates if the first row of the CSV is used as column names. Can be true, false, or an array of strings. Default is true.
`skip`: Number of initial lines to skip before reading data. Default is 0.
`n_max`: Maximum number of rows to read. Default is Inf (read all rows).
`comment`: Character that starts a comment line. Lines beginning with this character are ignored. Default is nothing (no comment lines).
`missingstring`: String that represents missing values in the CSV. Default is "", can be set to a vector of multiple items.
`escape_double`: Indicates whether to interpret two consecutive quote characters as a single quote in the data. Default is true.
`col_types`: An optional specification of column types, can be a single type applied to all columns, or a collection of types with one for each column. Default is nothing (types are inferred).

# Examples
```jldoctest 


```
"""

"""
    read_delim(file; delim='\t',col_names=true, skip=0, n_max=Inf, 
        comment=nothing, missingstring="", escape_double=true, col_types=nothing)

Reads a delimited file or URL into a DataFrame, with options to specify delimiter, column names, and other CSV parsing options.

# Arguments
`file`: Path to the CSV file or a URL to a CSV file.
`delim`: The character delimiting fields in the file. Default is ','.
`col_names`: Indicates if the first row of the CSV is used as column names. Can be true, false, or an array of strings. Default is true.
`skip`: Number of initial lines to skip before reading data. Default is 0.
`n_max`: Maximum number of rows to read. Default is Inf (read all rows).
`comment`: Character that starts a comment line. Lines beginning with this character are ignored. Default is nothing (no comment lines).
`missingstring`: String that represents missing values in the CSV. Default is "", can be set to a vector of multiple items.
`escape_double`: Indicates whether to interpret two consecutive quote characters as a single quote in the data. Default is true.
`col_types`: An optional specification of column types, can be a single type applied to all columns, or a collection of types with one for each column. Default is nothing (types are inferred).

# Examples
```jldoctest 


```
"""



"""
    read_fwf(filepath::String; num_lines::Int=4, col_names=nothing)
Read fixed-width format (FWF) files into a DataFrame.

# Arguments
- `filepath`::String: Path to the FWF file to read.
- `widths_colnames`::Tuple{Vector{Int}, Union{Nothing, Vector{String}}}: A tuple containing two elements:
        - A vector of integers specifying the widths of each field.
        - Optionally, a vector of strings specifying column names. If nothing, column names are generated as Column_1, Column_2, etc.
- `skip_to`=0: Number of lines at the beginning of the file to skip before reading data.
- `n_max`=nothing: Maximum number of lines to read from the file. If nothing, read all lines.
# Examples
```jldoctest 

```
"""


"""
    fwf_empty(filepath::String; num_lines::Int=4, col_names=nothing)

Analyze a fixed-width format (FWF) file to automatically determine column widths and provide column names.

# Arguments
- `filepath`::String: Path to the FWF file to analyze.
num_lines::Int=4: Number of lines to sample from the beginning of the file for analysis. Default is 4.
- `col_names`: Optional; a vector of strings specifying column names. If not provided, column names are generated as Column_1, Column_2, etc.
# Returns
- A tuple containing two elements:
- A vector of integers representing the detected column widths.
- A vector of strings representing the column names.
# Examples
```jldoctest 


```
"""


"""
    write_csv(DataFrame, filepath; na = "", append = false, col_names = true, eol = "\n", num_threads = Threads.nthreads())
Write a DataFrame to a CSV (comma-separated values) file.

# Arguments
- `x`: The DataFrame to write to the CSV file.
- `file`: The path to the output CSV file.
- `na`: = "": The string to represent missing values in the output file. Default is an empty string.
- `append`: Whether to append to the file if it already exists. Default is false.
- `col_names`: = true: Whether to write column names as the first line of the file. Default is true.
- `eol`: = "\n": The end-of-line character to use in the output file. Default is the newline character.
- `num_threads` = Threads.nthreads(): The number of threads to use for writing the file. Default is the number of available threads.

# Examples
```jldoctest 


```
"""

"""
    write_tsv(DataFrame, filepath; na = "", append = false, col_names = true, eol = "\n", num_threads = Threads.nthreads())
Write a DataFrame to a TSV (tab-separated values) file.

# Arguments
- `x`: The DataFrame to write to the TSV file.
- `file`: The path to the output TSV file.
- `na`: = "": The string to represent missing values in the output file. Default is an empty string.
- `append`: Whether to append to the file if it already exists. Default is false.
- `col_names`: = true: Whether to write column names as the first line of the file. Default is true.
- `eol`: = "\n": The end-of-line character to use in the output file. Default is the newline character.
- `num_threads` = Threads.nthreads(): The number of threads to use for writing the file. Default is the number of available threads.

# Examples
```jldoctest 


```
"""

"""
    read_table(file; col_names=true, skip=0, n_max=Inf, comment=nothing, missingstring="", kwargs...)

Read a table from a file where columns are separated by any amount of whitespace, processing it into a DataFrame.

# Arguments
-`file`: The path to the file to read.
-`col_names`=true: Indicates whether the first non-skipped line should be treated as column names. If false, columns are named automatically.
-`skip`: Number of lines at the beginning of the file to skip before processing starts.
-`n_max`: The maximum number of lines to read from the file, after skipping. Inf means read all lines.
-`comment`: A character or string indicating the start of a comment. Lines starting with this character are ignored.
-`missingstring`: The string that represents missing values in the table.
-`kwargs`: Additional keyword arguments passed to CSV.File.
# Examples
```jldoctest 


```
"""


"""
    write_table(x, file; delim = '\t', na, append, col_names, eol, num_threads)
Write a DataFrame to a file, allowing for customization of the delimiter and other options.

# Arguments
-`x`: The DataFrame to write to a file.
-`file`: The path to the file where the DataFrame will be written.
-delim: Character to use as the field delimiter. The default is tab ('\t'), making it a TSV (tab-separated values) file by default, but can be changed to accommodate other formats.
-`na`: The string to represent missing data in the output file.
-`append`: Whether to append to the file if it already exists. If false, the file will be overwritten.
-`col_names`: Whether to write column names as the first line of the file. If appending to an existing file with append = true, column names will not be written regardless of this parameter's value.
-`eol`: The end-of-line character to use in the file. Defaults to "\n".
-`num_threads`: Number of threads to use for writing the file. Uses the number of available Julia threads by default.

# Examples
```jldoctest 


```
"""

"""
    read_excel(path; sheet, range, col_names, col_types, missingstring, trim_ws, skip, n_max, guess_max)
Read data from an Excel file into a DataFrame.

# Arguments
-`path`: The path to the Excel file to be read.
-`sheet`: Specifies the sheet to be read. Can be either the name of the sheet as a string or its index as an integer. If nothing, the first sheet is read.
-`range`: Specifies a specific range of cells to be read from the sheet. If nothing, the entire sheet is read.
-`col_names`: Indicates whether the first row of the specified range should be treated as column names. If false, columns will be named automatically.
-`col_types`: Allows specifying column types explicitly. Can be a single type applied to all columns, a list or a dictionary mapping column names or indices to types. If nothing, types will be inferred.
-`missingstring`: The string that represents missing values in the Excel file.
-`trim_ws`: Whether to trim leading and trailing whitespace from cells in the Excel file.
-`skip`: Number of rows to skip at the beginning of the sheet or range before reading data.
-`n_max`: The maximum number of rows to read from the sheet or range, after skipping. Inf means read all available rows.
-`guess_max`: The maximum number of rows to scan for type guessing and column names detection. Only relevant if col_types is nothing or col_names is true. If nothing, a default heuristic is used.

# Examples
```jldoctest 


```
"""

"""
    write_excel(x; path, overwrite)
Write a DataFrame, or multiple DataFrames, to an Excel file.

#Arguments
-`x`: The data to write. Can be a single Pair{String, DataFrame} for writing one sheet, or a Tuple of such pairs for writing multiple sheets. The String in each pair specifies the sheet name, and the DataFrame is the data to write to that sheet.
-`path`: The path to the Excel file where the data will be written.
-`overwrite`: Defaults to false. Whether to overwrite an existing file. If false, an error is thrown when attempting to write to an existing file.

# Examples
```jldoctest 


```
"""