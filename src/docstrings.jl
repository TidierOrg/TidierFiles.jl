const docstring_read_csv  =
"""
    read_csv(file; delim=',',col_names=true, skip=0, n_max=Inf, 
        comment=nothing, missingstring="", col_select, escape_double=true, col_types=nothing, num_threads = 1)

Reads a CSV file or URL into a DataFrame, with options to specify delimiter, column names, and other CSV parsing options.

# Arguments
`file`: Path to the CSV file or a URL to a CSV file.
`delim`: The character delimiting fields in the file. Default is ','.
`col_names`: Indicates if the first row of the CSV is used as column names. Can be true, false, or an array of strings. Default is true.
`skip`: Number of initial lines to skip before reading data. Default is 0.
`n_max`: Maximum number of rows to read. Default is Inf (read all rows).
-`col_select`: Optional vector of symbols or strings to select which columns to load.
`comment`: Character that starts a comment line. Lines beginning with this character are ignored. Default is nothing (no comment lines).
`missingstring`: String that represents missing values in the CSV. Default is "", can be set to a vector of multiple items.
`escape_double`: Indicates whether to interpret two consecutive quote characters as a single quote in the data. Default is true.
`num_threads`: specifies the number of concurrent tasks or threads to use for processing, allowing for parallel execution. Defaults to 1
# Examples
```jldoctest 
julia> read_csv("csvtest.csv", skip = 2, n_max = 3, missingstring = ["95", "Charlie"])
3×3 DataFrame
 Row │ ID     Name     Score   
     │ Int64  String7  Int64?  
─────┼─────────────────────────
   1 │     3  missing       77
   2 │     4  David         85
   3 │     5  Eva      missing 
```
"""

const docstring_read_tsv  =
"""
    read_tsv(file; delim='\t',col_names=true, skip=0, n_max=Inf, 
        comment=nothing, missingstring="", col_select, escape_double=true, col_types=nothing)

Reads a TSV file or URL into a DataFrame, with options to specify delimiter, column names, and other CSV parsing options.

# Arguments
`file`: Path to the TSV file or a URL to a TSV file.
`delim`: The character delimiting fields in the file. Default is ','.
`col_names`: Indicates if the first row of the CSV is used as column names. Can be true, false, or an array of strings. Default is true.
`skip`: Number of initial lines to skip before reading data. Default is 0.
`n_max`: Maximum number of rows to read. Default is Inf (read all rows).
-`col_select`: Optional vector of symbols or strings to select which columns to load.
`comment`: Character that starts a comment line. Lines beginning with this character are ignored. Default is nothing (no comment lines).
`missingstring`: String that represents missing values in the CSV. Default is "", can be set to a vector of multiple items.
`escape_double`: Indicates whether to interpret two consecutive quote characters as a single quote in the data. Default is true.
`num_threads`: specifies the number of concurrent tasks or threads to use for processing, allowing for parallel execution. Default is the number of available threads.

# Examples
```jldoctest 
julia> read_tsv("tsvtest.tsv", skip = 2, n_max = 3, missingstring = ["Charlie"])
3×3 DataFrame
 Row │ ID     Name     Score 
     │ Int64  String7  Int64 
─────┼───────────────────────
   1 │     3  missing     77
   2 │     4  David       85
   3 │     5  Eva         95
```
"""

const docstring_read_delim = 
"""
    read_delim(file; delim='\t',col_names=true, skip=0, n_max=Inf, 
        comment=nothing, missingstring="", col_select, escape_double=true, col_types=nothing)

Reads a delimited file or URL into a DataFrame, with options to specify delimiter, column names, and other CSV parsing options.

# Arguments
`file`: Path to the CSV file or a URL to a CSV file.
`delim`: The character delimiting fields in the file. Default is ','.
`col_names`: Indicates if the first row of the CSV is used as column names. Can be true, false, or an array of strings. Default is true.
`skip`: Number of initial lines to skip before reading data. Default is 0.
`n_max`: Maximum number of rows to read. Default is Inf (read all rows).
-`col_select`: Optional vector of symbols or strings to select which columns to load.
`comment`: Character that starts a comment line. Lines beginning with this character are ignored. Default is nothing (no comment lines).
`missingstring`: String that represents missing values in the CSV. Default is "", can be set to a vector of multiple items.
`escape_double`: Indicates whether to interpret two consecutive quote characters as a single quote in the data. Default is true.
`col_types`: An optional specification of column types, can be a single type applied to all columns, or a collection of types with one for each column. Default is nothing (types are inferred).
`num_threads`: specifies the number of concurrent tasks or threads to use for processing, allowing for parallel execution. Default is the number of available threads.

# Examples
```jldoctest 
julia> read_delim("csvtest.csv", delim = ",", col_names = false, num_threads = 4) # col_names are false here for the purpose of demonstration
6×3 DataFrame
 Row │ Column1  Column2  Column3 
     │ String3  String7  String7 
─────┼───────────────────────────
   1 │ ID       Name     Score
   2 │ 1        Alice    88
   3 │ 2        Bob      92
   4 │ 3        Charlie  77
   5 │ 4        David    85
   6 │ 5        Eva      95
```
"""

const docstring_read_fwf =
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
julia> path = "fwftest.txt";

julia> read_fwf(path, fwf_empty(path, num_lines=4, col_names = ["Name", "Age", "ID", "Position", "Salary"]), skip_to=3, n_max=3)
3×5 DataFrame
 Row │ Name         Age     ID      Position         Salary  
     │ String       String  String  String           String  
─────┼───────────────────────────────────────────────────────
   1 │ Bob Brown    31      12345   Product Manager  110,000
   2 │ Charlie Day  28      345     Sales Associate  70,000
   3 │ Diane Poe    35      23456   Data Scientist   130,000
```
"""

const docstring_fwf_empty =
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
julia> path = "fwftest.txt";

julia> fwf_empty(path)
([13, 5, 8, 20, 8], ["Column_1", "Column_2", "Column_3", "Column_4", "Column_5"])

julia> fwf_empty(path, num_lines=4, col_names = ["Name", "Age", "ID", "Position", "Salary"])
([13, 5, 8, 20, 8], ["Name", "Age", "ID", "Position", "Salary"])
```
"""


const docstring_write_csv  =
"""
    write_csv(DataFrame, filepath; na = "", append = false, col_names = true, missingstring, eol = "\n", num_threads = Threads.nthreads())
Write a DataFrame to a CSV (comma-separated values) file.

# Arguments
- `x`: The DataFrame to write to the CSV file.
- `file`: The path to the output CSV file.
- `missingstring`: = "": The string to represent missing values in the output file. Default is an empty string.
- `append`: Whether to append to the file if it already exists. Default is false.
- `col_names`: = true: Whether to write column names as the first line of the file. Default is true.
- `eol`: = "\n": The end-of-line character to use in the output file. Default is the newline character.
- `num_threads` = Threads.nthreads(): The number of threads to use for writing the file. Default is the number of available threads.

# Examples
```jldoctest 
julia> df = DataFrame(ID = 1:5, Name = ["Alice", "Bob", "Charlie", "David", "Eva"], Score = [88, 92, 77, 85, 95]);

julia> write_csv(df, "csvtest.csv");
```
"""

const docstring_write_tsv  =
"""
    write_tsv(DataFrame, filepath; na = "", append = false, col_names = true, missingstring, eol = "\n", num_threads = Threads.nthreads())
Write a DataFrame to a TSV (tab-separated values) file.

# Arguments
- `x`: The DataFrame to write to the TSV file.
- `file`: The path to the output TSV file.
- `missingstring`: = "": The string to represent missing values in the output file. Default is an empty string.
- `append`: Whether to append to the file if it already exists. Default is false.
- `col_names`: = true: Whether to write column names as the first line of the file. Default is true.
- `eol`: = "\n": The end-of-line character to use in the output file. Default is the newline character.
- `num_threads` = Threads.nthreads(): The number of threads to use for writing the file. Default is the number of available threads.

# Examples
```jldoctest 
julia> df = DataFrame(ID = 1:5, Name = ["Alice", "Bob", "Charlie", "David", "Eva"], Score = [88, 92, 77, 85, 95]);

julia> write_tsv(df, "tsvtest.tsv");
```
"""

const docstring_read_table =
"""
    read_table(file; col_names=true, skip=0, n_max=Inf, comment=nothing, col_select, missingstring="", kwargs...)

Read a table from a file where columns are separated by any amount of whitespace, processing it into a DataFrame.

# Arguments
-`file`: The path to the file to read.
-`col_names`=true: Indicates whether the first non-skipped line should be treated as column names. If false, columns are named automatically.
-`skip`: Number of lines at the beginning of the file to skip before processing starts.
-`n_max`: The maximum number of lines to read from the file, after skipping. Inf means read all lines.
-`col_select`: Optional vector of symbols or strings to select which columns to load.
-`comment`: A character or string indicating the start of a comment. Lines starting with this character are ignored.
-`missingstring`: The string that represents missing values in the table.
-`kwargs`: Additional keyword arguments passed to CSV.File.
# Examples
```jldoctest 
julia> read_table("tabletest.txt", skip = 2, n_max = 3, col_select = ["Name"])
3×1 DataFrame
 Row │ Name    
     │ String7 
─────┼─────────
   1 │ Charlie
   2 │ David
   3 │ Eva

```
"""

const docstring_write_table =
"""
    write_table(x, file; delim = '\t', na, append, col_names, eol, num_threads)
Write a DataFrame to a file, allowing for customization of the delimiter and other options.

# Arguments
-`x`: The DataFrame to write to a file.
-`file`: The path to the file where the DataFrame will be written.
-delim: Character to use as the field delimiter. The default is tab ('\t'), making it a TSV (tab-separated values) file by default, but can be changed to accommodate other formats.
-`missingstring`: The string to represent missing data in the output file.
-`append`: Whether to append to the file if it already exists. If false, the file will be overwritten.
-`col_names`: Whether to write column names as the first line of the file. If appending to an existing file with append = true, column names will not be written regardless of this parameter's value.
-`eol`: The end-of-line character to use in the file. Defaults to "\n".
-`num_threads`: Number of threads to use for writing the file. Uses the number of available Julia threads by default.

# Examples
```jldoctest 
julia> df = DataFrame(ID = 1:5, Name = ["Alice", "Bob", "Charlie", "David", "Eva"], Score = [88, 92, 77, 85, 95]);

julia> write_table(df, "tabletest.txt");
```
"""

const docstring_read_xlsx =
"""
    read_xlsx(path; sheet, range, col_names, col_types, missingstring, trim_ws, skip, n_max, guess_max)
Read data from an Excel file into a DataFrame.

# Arguments
-`path`: The path to the Excel file to be read.
-`sheet`: Specifies the sheet to be read. Can be either the name of the sheet as a string or its index as an integer. If nothing, the first sheet is read.
-`range`: Specifies a specific range of cells to be read from the sheet. If nothing, the entire sheet is read.
-`col_names`: Indicates whether the first row of the specified range should be treated as column names. If false, columns will be named automatically.
-`col_types`: Allows specifying column types explicitly. Can be a single type applied to all columns, a list or a dictionary mapping column names or indices to types. If nothing, types will be inferred.
-`missingstring`: The value or vector that represents missing values in the Excel file.
-`trim_ws`: Whether to trim leading and trailing whitespace from cells in the Excel file.
-`skip`: Number of rows to skip at the beginning of the sheet or range before reading data.
-`n_max`: The maximum number of rows to read from the sheet or range, after skipping. Inf means read all available rows.
-`guess_max`: The maximum number of rows to scan for type guessing and column names detection. Only relevant if col_types is nothing or col_names is true. If nothing, a default heuristic is used.

# Examples
```jldoctest 
julia> read_xlsx("xlsxtest.xlsx", sheet = "REPORT_A", skip = 1, n_max = 4, missingstring = [2])
3×3 DataFrame
 Row │ integers  strings               floats  
     │ Any       String                Float64 
─────┼─────────────────────────────────────────
   1 │ missing   Package makes            20.3
   2 │ 3         File reading/writing     30.4
   3 │ 4         even smoother            40.5
```
"""

const docstring_write_xlsx =
"""
    write_xlsx(x; path, overwrite)
Write a DataFrame, or multiple DataFrames, to an Excel file.

#Arguments
-`x`: The data to write. Can be a single Pair{String, DataFrame} for writing one sheet, or a Tuple of such pairs for writing multiple sheets. The String in each pair specifies the sheet name, and the DataFrame is the data to write to that sheet.
-`path`: The path to the Excel file where the data will be written.
-`overwrite`: Defaults to false. Whether to overwrite an existing file. If false, an error is thrown when attempting to write to an existing file.

# Examples
```jldoctest 
julia> df = DataFrame(integers=[1, 2, 3, 4],
       strings=["This", "Package makes", "File reading/writing", "even smoother"],
       floats=[10.2, 20.3, 30.4, 40.5]);

julia> df2 = DataFrame(AA=["aa", "bb"], AB=[10.1, 10.2]);

julia> write_xlsx(("REPORT_A" => df, "REPORT_B" => df2); path="xlsxtest.xlsx", overwrite = true);
```
"""

const docstring_read_dta  =
"""

    function read_dta(data_file;  encoding=nothing, col_select=nothing, skip=0, n_max=Inf)
Read data from a Stata (.dta) file into a DataFrame, supporting both local and remote sources.

# Arguments
-`filepath`: The path to the .dta file or a URL pointing to such a file. If a URL is provided, the file will be downloaded and then read.
`encoding`: Optional; specifies the encoding of the input file. If not provided, defaults to the package's or function's default.
`col_select`: Optional; allows specifying a subset of columns to read. This can be a vector of column names or indices. If nothing, all columns are read.
skip=0: Number of rows at the beginning of the file to skip before reading.
n_max=Inf: Maximum number of rows to read from the file, after skipping. If Inf, read all available rows.
`num_threads`: specifies the number of concurrent tasks or threads to use for processing, allowing for parallel execution. Defaults to 1

# Examples
```jldoctest 
julia> read_sas("test.dta")
2×2 DataFrame
 Row │ AA       AB      
     │ String3  Float64 
─────┼──────────────────
   1 │ sav         10.1
   2 │ por         10.2
```
"""

const docstring_read_sas =
"""
    function read_sas(data_file;  encoding=nothing, col_select=nothing, skip=0, n_max=Inf, num_threads)
Read data from a SAS (.sas7bdat and .xpt) file into a DataFrame, supporting both local and remote sources.

# Arguments
-`filepath`: The path to the .dta file or a URL pointing to such a file. If a URL is provided, the file will be downloaded and then read.
`encoding`: Optional; specifies the encoding of the input file. If not provided, defaults to the package's or function's default.
`col_select`: Optional; allows specifying a subset of columns to read. This can be a vector of column names or indices. If nothing, all columns are read.
skip=0: Number of rows at the beginning of the file to skip before reading.
n_max=Inf: Maximum number of rows to read from the file, after skipping. If Inf, read all available rows.
`num_threads`: specifies the number of concurrent tasks or threads to use for processing, allowing for parallel execution. Defaults to 1

# Examples
```jldoctest 
julia> read_sas("test.sas7bdat")
2×2 DataFrame
 Row │ AA       AB      
     │ String3  Float64 
─────┼──────────────────
   1 │ sav         10.1
   2 │ por         10.2

julia> read_sas("test.xpt")
2×2 DataFrame
 Row │ AA       AB      
     │ String3  Float64 
─────┼──────────────────
   1 │ sav         10.1
   2 │ por         10.2
"""

const docstring_read_sav  =
"""
    function read_sav(data_file;  encoding=nothing, col_select=nothing, skip=0, n_max=Inf)
Read data from a SPSS (.sav and .por) file into a DataFrame, supporting both local and remote sources.

# Arguments
-`filepath`: The path to the .sav or .por file or a URL pointing to such a file. If a URL is provided, the file will be downloaded and then read.
`encoding`: Optional; specifies the encoding of the input file. If not provided, defaults to the package's or function's default.
`col_select`: Optional; allows specifying a subset of columns to read. This can be a vector of column names or indices. If nothing, all columns are read.
skip=0: Number of rows at the beginning of the file to skip before reading.
n_max=Inf: Maximum number of rows to read from the file, after skipping. If Inf, read all available rows.
`num_threads`: specifies the number of concurrent tasks or threads to use for processing, allowing for parallel execution. Defaults to 1

# Examples
```jldoctest 
julia> read_sav("test.sav")
2×2 DataFrame
 Row │ AA      AB      
     │ String  Float64 
─────┼─────────────────
   1 │ sav        10.1
   2 │ por        10.2

julia> read_sav("test.por")
2×2 DataFrame
 Row │ AA      AB      
     │ String  Float64 
─────┼─────────────────
   1 │ sav        10.1
   2 │ por        10.2
```
"""

const docstring_write_sav =
"""
    write_sav(df, path)
Write a DataFrame to a SPSS (.sav or .por) file.

Arguments
-`df`: The DataFrame to be written to a file.
-`path`: String as path where the .dta file will be created. If a file at this path already exists, it will be overwritten.

# Examples
```jldoctest 
julia> df = DataFrame(AA=["sav", "por"], AB=[10.1, 10.2]);

julia> write_sav(df, "test.sav")
2×2 ReadStatTable:
 Row │     AA        AB 
     │ String  Float64? 
─────┼──────────────────
   1 │    sav      10.1
   2 │    por      10.2

julia> write_sav(df, "test.por")
2×2 ReadStatTable:
 Row │     AA        AB 
     │ String  Float64? 
─────┼──────────────────
   1 │    sav      10.1
   2 │    por      10.2
```
"""
const docstring_write_sas =
"""
    write_sas(df, path)
Write a DataFrame to a SAS (.sas7bdat or .xpt) file.

Arguments
-`df`: The DataFrame to be written to a file.
-`path`: String as path where the .dta file will be created. If a file at this path already exists, it will be overwritten.

# Examples
```jldoctest 
julia> df = DataFrame(AA=["sav", "por"], AB=[10.1, 10.2]);

julia> write_sas(df , "test.sas7bdat")
2×2 ReadStatTable:
 Row │     AA        AB 
     │ String  Float64? 
─────┼──────────────────
   1 │    sav      10.1
   2 │    por      10.2

julia> write_sas(df , "test.xpt")
2×2 ReadStatTable:
 Row │     AA        AB 
     │ String  Float64? 
─────┼──────────────────
   1 │    sav      10.1
   2 │    por      10.2
```
"""

const docstring_write_dta =
"""
    write_dta(df, path)
Write a DataFrame to a Stata (.dta) file.

Arguments
-`df`: The DataFrame to be written to a file.
-`path`: String as path where the .dta file will be created. If a file at this path already exists, it will be overwritten.

# Examples
```jldoctest 
julia> df = DataFrame(AA=["sav", "por"], AB=[10.1, 10.2]);

julia> write_dta(df , "test.dta")
2×2 ReadStatTable:
 Row │     AA        AB 
     │ String  Float64? 
─────┼──────────────────
   1 │    sav      10.1
   2 │    por      10.2
```
"""