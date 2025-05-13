const docstring_read_csv  =
"""
    read_csv(file; delim=',',col_names=true, skip=0, n_max=Inf, 
        comment=nothing, missing_value="", col_select, escape_double=true, col_types=nothing, num_threads = 1)

Reads a CSV file or URL into a DataFrame, with options to specify delimiter, column names, and other CSV parsing options.

# Arguments
- `file`: Path or vector of paths to the CSV file or a URL to a CSV file.
- `delim`: The character delimiting fields in the file. Default is ','.
- `decimal`: Character argument for what character decimal should be. Default is `.`
- `col_names`: Indicates if the first row of the CSV is used as column names. Can be true, false, or an array of strings. Default is true.
- `skip`: Number of initial lines to skip before reading data. Default is 0.
- `n_max`: Maximum number of rows to read. Default is Inf (read all rows).
- `col_select`: Optional vector of symbols or strings to select which columns to load.
- `col_types`: Optional Dict to allow for column type specification
- `comment`: Character that starts a comment line. Lines beginning with this character are ignored. Default is nothing (no comment lines).
- `missing_value`: String that represents missing values in the CSV. Default is "", can be set to a vector of multiple items.
- `escape_double`: Indicates whether to interpret two consecutive quote characters as a single quote in the data. Default is true.
- `num_threads`: specifies the number of concurrent tasks or threads to use for processing, allowing for parallel execution. Defaults to 1
# Examples
```jldoctest
julia> df = DataFrame(ID = 1:5, Name = ["Alice", "Bob", "Charlie", "David", "Eva"], Score = [88, 92, 77, 85, 95]);

julia> write_csv(df, "csvtest.csv");

julia> read_csv("csvtest.csv", skip = 2, n_max = 3, missing_value = ["95", "Charlie"])
3×3 DataFrame
 Row │ ID     Name      Score   
     │ Int64  String7?  Int64?  
─────┼──────────────────────────
   1 │     3  missing        77
   2 │     4  David          85
   3 │     5  Eva       missing 

julia> read_csv("csvtest.csv", skip = 2, n_max = 3, col_types = Dict(:ID => Float64))
3×3 DataFrame
 Row │ ID       Name     Score 
     │ Float64  String7  Int64 
─────┼─────────────────────────
   1 │     3.0  Charlie     77
   2 │     4.0  David       85
   3 │     5.0  Eva         95
```
"""

const docstring_read_tsv  =
"""
    read_tsv(file; delim='\t',col_names=true, skip=0, n_max=Inf, 
        comment=nothing, missing_value="", col_select, escape_double=true, col_types=nothing)

Reads a TSV file or URL into a DataFrame, with options to specify delimiter, column names, and other CSV parsing options.

# Arguments
- `file`: Path or vector of paths to the TSV file or a URL to a TSV file.
- `delim`: The character delimiting fields in the file. Default is ','.
- `decimal`: Character argument for what character decimal should be. Default is `.`
- `col_names`: Indicates if the first row of the CSV is used as column names. Can be true, false, or an array of strings. Default is true.
- `skip`: Number of initial lines to skip before reading data. Default is 0.
- `n_max`: Maximum number of rows to read. Default is Inf (read all rows).
- `col_select`: Optional vector of symbols or strings to select which columns to load.
- `comment`: Character that starts a comment line. Lines beginning with this character are ignored. Default is nothing (no comment lines).
- `col_types`: Optional Dict to allow for column type specification
- `missing_value`: String that represents missing values in the CSV. Default is "", can be set to a vector of multiple items.
- `escape_double`: Indicates whether to interpret two consecutive quote characters as a single quote in the data. Default is true.
- `num_threads`: specifies the number of concurrent tasks or threads to use for processing, allowing for parallel execution. Default is the number of available threads.

# Examples
```jldoctest
julia> df = DataFrame(ID = 1:5, Name = ["Alice", "Bob", "Charlie", "David", "Eva"], Score = [88, 92, 77, 85, 95]);

julia> write_tsv(df, "tsvtest.tsv");

julia> read_tsv("tsvtest.tsv", skip = 2, n_max = 3, missing_value = ["Charlie"])
3×3 DataFrame
 Row │ ID     Name      Score 
     │ Int64  String7?  Int64 
─────┼────────────────────────
   1 │     3  missing      77
   2 │     4  David        85
   3 │     5  Eva          95
```
"""

const docstring_read_delim = 
"""
    read_delim(file; delim='\t',col_names=true, skip=0, n_max=Inf, 
        comment=nothing, missing_value="", col_select, escape_double=true, col_types=nothing)

Reads a delimited file or URL into a DataFrame, with options to specify delimiter, column names, and other CSV parsing options.

# Arguments
- `file`: Path or vector of paths to the CSV file or a URL to a CSV file.
- `delim`: The character delimiting fields in the file. Default is ','.
- `decimal`: Character argument for what character decimal should be. Default is `.`
- `col_names`: Indicates if the first row of the CSV is used as column names. Can be true, false, or an array of strings. Default is true.
- `skip`: Number of initial lines to skip before reading data. Default is 0.
- `n_max`: Maximum number of rows to read. Default is Inf (read all rows).
- `col_select`: Optional vector of symbols or strings to select which columns to load.
- `comment`: Character that starts a comment line. Lines beginning with this character are ignored. Default is nothing (no comment lines).
- `col_types`: Optional Dict to allow for column type specification
- `missing_value`: String that represents missing values in the CSV. Default is "", can be set to a vector of multiple items.
- `escape_double`: Indicates whether to interpret two consecutive quote characters as a single quote in the data. Default is true.
- `num_threads`: specifies the number of concurrent tasks or threads to use for processing, allowing for parallel execution. Default is the number of available threads.

# Examples
```jldoctest
julia> df = DataFrame(ID = 1:5, Name = ["Alice", "Bob", "Charlie", "David", "Eva"], Score = [88, 92, 77, 85, 95]);

julia> write_csv(df, "csvtest.csv");

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
julia> fwf_data = 
       "John Smith   35    12345  Software Engineer   120,000 \\nJane Doe     29     2345  Marketing Manager   95,000  \\nAlice Jones  42   123456  CEO                 250,000 \\nBob Brown    31    12345  Product Manager     110,000 \\nCharlie Day  28      345  Sales Associate     70,000  \\nDiane Poe    35    23456  Data Scientist      130,000 \\nEve Stone    40   123456  Chief Financial Off 200,000 \\nFrank Moore  33     1234  Graphic Designer    80,000  \\nGrace Lee    27   123456  Software Developer  115,000 \\nHank Zuse    45    12345  System Analyst      120,000 ";

julia> open("fwftest.txt", "w") do file
         write(file, fwf_data)
       end;

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
julia> fwf_data = 
       "John Smith   35    12345  Software Engineer   120,000 \\nJane Doe     29     2345  Marketing Manager   95,000  \\nAlice Jones  42   123456  CEO                 250,000 \\nBob Brown    31    12345  Product Manager     110,000 \\nCharlie Day  28      345  Sales Associate     70,000  \\nDiane Poe    35    23456  Data Scientist      130,000 \\nEve Stone    40   123456  Chief Financial Off 200,000 \\nFrank Moore  33     1234  Graphic Designer    80,000  \\nGrace Lee    27   123456  Software Developer  115,000 \\nHank Zuse    45    12345  System Analyst      120,000 ";

julia> open("fwftest.txt", "w") do file
         write(file, fwf_data)
       end;

julia> path = "fwftest.txt";

julia> fwf_empty(path)
([13, 5, 8, 20, 8], ["Column_1", "Column_2", "Column_3", "Column_4", "Column_5"])

julia> fwf_empty(path, num_lines=4, col_names = ["Name", "Age", "ID", "Position", "Salary"])
([13, 5, 8, 20, 8], ["Name", "Age", "ID", "Position", "Salary"])
```
"""

const docstring_write_csv  =
"""
    write_csv(DataFrame, filepath; na = "", append = false, col_names = true, missing_value, eol = "\n", num_threads = Threads.nthreads())
Write a DataFrame to a CSV (comma-separated values) file.

# Arguments
- `x`: The DataFrame to write to the CSV file.
- `file`: The path to the output CSV file.
- `missing_value`: = "": The string to represent missing values in the output file. Default is an empty string.
- `delim`: delimiter for file. can be a character or string. default `,` 
- `append`: Whether to append to the file if it already exists. Default is false.
- `col_names`: = true: Whether to write column names as the first line of the file. Default is true.
- `eol`: The end-of-line character to use in the output file. Default is the newline character.
- `num_threads` = Threads.nthreads(): The number of threads to use for writing the file. Default is the number of available threads.

# Examples
```jldoctest 
julia> df = DataFrame(ID = 1:5, Name = ["Alice", "Bob", "Charlie", "David", "Eva"], Score = [88, 92, 77, 85, 95]);

julia> write_csv(df, "csvtest.csv");
```
"""

const docstring_write_tsv  =
"""
    write_tsv(DataFrame, filepath; na = "", append = false, col_names = true, missing_value, eol = "\n", num_threads = Threads.nthreads())
Write a DataFrame to a TSV (tab-separated values) file.

# Arguments
- `x`: The DataFrame to write to the TSV file.
- `file`: The path to the output TSV file.
- `missing_value`: = "": The string to represent missing values in the output file. Default is an empty string.
- `append`: Whether to append to the file if it already exists. Default is false.
- `col_names`: = true: Whether to write column names as the first line of the file. Default is true.
- `eol`: The end-of-line character to use in the output file. Default is the newline character.
- `num_threads` = Threads.nthreads(): The number of threads to use for writing the file. Default is the number of available threads.

# Examples
```jldoctest 
julia> df = DataFrame(ID = 1:5, Name = ["Alice", "Bob", "Charlie", "David", "Eva"], Score = [88, 92, 77, 85, 95]);

julia> write_tsv(df, "tsvtest.tsv");
```
"""

const docstring_read_table =
"""
    read_table(file; col_names=true, skip=0, n_max=Inf, comment=nothing, col_select, missing_value="", kwargs...)

Read a table from a file where columns are separated by any amount of whitespace, processing it into a DataFrame.

# Arguments
- `file`: The path to the file to read.
- `col_names`=true: Indicates whether the first non-skipped line should be treated as column names. If false, columns are named automatically.
- `skip`: Number of lines at the beginning of the file to skip before processing starts.
- `n_max`: The maximum number of lines to read from the file, after skipping. Inf means read all lines.
- `col_select`: Optional vector of symbols or strings to select which columns to load.
- `comment`: A character or string indicating the start of a comment. Lines starting with this character are ignored.
- `missing_value`: The string that represents missing values in the table.
- `kwargs`: Additional keyword arguments passed to CSV.File.
# Examples
```jldoctest 
julia> df = DataFrame(ID = 1:5, Name = ["Alice", "Bob", "Charlie", "David", "Eva"], Score = [88, 92, 77, 85, 95]);

julia> write_table(df, "tabletest.txt");

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
- `x`: The DataFrame to write to a file.
- `file`: The path to the file where the DataFrame will be written.
-delim: Character to use as the field delimiter. The default is tab ('\t'), making it a TSV (tab-separated values) file by default, but can be changed to accommodate other formats.
- `missing_value`: The string to represent missing data in the output file.
- `append`: Whether to append to the file if it already exists. If false, the file will be overwritten.
- `col_names`: Whether to write column names as the first line of the file. If appending to an existing file with append = true, column names will not be written regardless of this parameter's value.
- `eol`: The end-of-line character to use in the file. Defaults to "\n".
- `num_threads`: Number of threads to use for writing the file. Uses the number of available Julia threads by default.

# Examples
```jldoctest 
julia> df = DataFrame(ID = 1:5, Name = ["Alice", "Bob", "Charlie", "David", "Eva"], Score = [88, 92, 77, 85, 95]);

julia> write_table(df, "tabletest.txt");
```
"""

const docstring_read_xlsx =
"""
    read_xlsx(path; sheet, range, col_names, col_types, missing_value, trim_ws, skip, n_max, guess_max)
Read data from an Excel file into a DataFrame.

# Arguments
- `path`: The path to the Excel file to be read.
- `sheet`: Specifies the sheet to be read. Can be either the name of the sheet as a string or its index as an integer. If nothing, the first sheet is read.
- `range`: Specifies a specific range of cells to be read from the sheet. If nothing, the entire sheet is read.
- `col_names`: Indicates whether the first row of the specified range should be treated as column names. If false, columns will be named automatically.
- `col_types`: Allows specifying column types explicitly. Can be a single type applied to all columns, a list or a dictionary mapping column names or indices to types. If nothing, types will be inferred.
- `missing_value`: The value or vector that represents missing values in the Excel file. Unlike CSV.jl based functions, everything does not need to be written as a string
- `trim_ws`: Whether to trim leading and trailing whitespace from cells in the Excel file.
- `skip`: Number of rows to skip at the beginning of the sheet or range before reading data.
- `n_max`: The maximum number of rows to read from the sheet or range, after skipping. Inf means read all available rows.
- `guess_max`: The maximum number of rows to scan for type guessing and column names detection. Only relevant if col_types is nothing or col_names is true. If nothing, a default heuristic is used.

# Examples
```jldoctest
julia> df = DataFrame(integers=[1, 2, 3, 4],
       strings=["This", "Package makes", "File reading/writing", "even smoother"],
       floats=[10.2, 20.3, 30.4, 40.5]);

julia> df2 = DataFrame(AA=["aa", "bb"], AB=[10.1, 10.2]);

julia> write_xlsx(("REPORT_A" => df, "REPORT_B" => df2); path="xlsxtest.xlsx", overwrite = true);

julia> read_xlsx("xlsxtest.xlsx", sheet = "REPORT_A", skip = 1, n_max = 4, missing_value = [2])
3×3 DataFrame
 Row │ integers  strings               floats   
     │ Int64?    String?               Float64? 
─────┼──────────────────────────────────────────
   1 │  missing  Package makes             20.3
   2 │        3  File reading/writing      30.4
   3 │        4  even smoother             40.5
```
"""

const docstring_write_xlsx =
"""
    write_xlsx(x; path, overwrite)
Write a DataFrame, or multiple DataFrames, to an Excel file. Specific sheets on can be specified for each dataframe.

# Arguments
- `x`: The data to write. Can be a single Pair{String, DataFrame} for writing one sheet, or a Tuple of such pairs for writing multiple sheets. The String in each pair specifies the sheet name, and the DataFrame is the data to write to that sheet.
- `path`: The path to the Excel file where the data will be written.
- `overwrite`: Defaults to false. Whether to overwrite an existing file. If false, an error is thrown when attempting to write to an existing file.

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
- `filepath`: The path to the .dta file or a URL pointing to such a file. If a URL is provided, the file will be downloaded and then read.
`encoding`: Optional; specifies the encoding of the input file. If not provided, defaults to the package's or function's default.
`col_select`: Optional; allows specifying a subset of columns to read. This can be a vector of column names or indices. If nothing, all columns are read.
- `skip=0`: Number of rows at the beginning of the file to skip before reading.
- `n_max=Inf`: Maximum number of rows to read from the file, after skipping. If Inf, read all available rows.
`num_threads`: specifies the number of concurrent tasks or threads to use for processing, allowing for parallel execution. Defaults to 1

# Examples
```jldoctest
julia> df = DataFrame(AA=["sav", "por"], AB=[10.1, 10.2]);

julia> write_dta(df, "test.dta");

julia> read_dta("test.dta")
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
- `filepath`: The path to the .dta file or a URL pointing to such a file. If a URL is provided, the file will be downloaded and then read.
`encoding`: Optional; specifies the encoding of the input file. If not provided, defaults to the package's or function's default.
`col_select`: Optional; allows specifying a subset of columns to read. This can be a vector of column names or indices. If nothing, all columns are read.
- `skip=0`: Number of rows at the beginning of the file to skip before reading.
- `n_max=Inf`: Maximum number of rows to read from the file, after skipping. If Inf, read all available rows.
`num_threads`: specifies the number of concurrent tasks or threads to use for processing, allowing for parallel execution. Defaults to 1

# Examples
```jldoctest
julia> df = DataFrame(AA=["sav", "por"], AB=[10.1, 10.2]);

julia> write_sas(df, "test.sas7bdat");

julia> read_sas("test.sas7bdat")
2×2 DataFrame
 Row │ AA       AB      
     │ String3  Float64 
─────┼──────────────────
   1 │ sav         10.1
   2 │ por         10.2

julia> write_sas(df, "test.xpt");

julia> read_sas("test.xpt")
2×2 DataFrame
 Row │ AA       AB      
     │ String3  Float64 
─────┼──────────────────
   1 │ sav         10.1
   2 │ por         10.2
```
"""

const docstring_read_sav =
"""
    function read_sav(data_file;  encoding=nothing, col_select=nothing, skip=0, n_max=Inf)
Read data from a SPSS (.sav and .por) file into a DataFrame, supporting both local and remote sources.

# Arguments
- `filepath`: The path to the .sav or .por file or a URL pointing to such a file. If a URL is provided, the file will be downloaded and then read.
- `encoding`: Optional; specifies the encoding of the input file. If not provided, defaults to the package's or function's default.
- `col_select`: Optional; allows specifying a subset of columns to read. This can be a vector of column names or indices. If nothing, all columns are read.
- `skip=0`: Number of rows at the beginning of the file to skip before reading.
- `n_max=Inf``: Maximum number of rows to read from the file, after skipping. If Inf, read all available rows.
- `num_threads`: specifies the number of concurrent tasks or threads to use for processing, allowing for parallel execution. Defaults to 1

# Examples
```jldoctest
julia> df = DataFrame(AA=["sav", "por"], AB=[10.1, 10.2]);

julia> write_sav(df, "test.sav");

julia> read_sav("test.sav")
2×2 DataFrame
 Row │ AA      AB      
     │ String  Float64 
─────┼─────────────────
   1 │ sav        10.1
   2 │ por        10.2

julia> write_sav(df, "test.por");

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

# Arguments
- `df`: The DataFrame to be written to a file.
- `path`: String as path where the .dta file will be created. If a file at this path already exists, it will be overwritten.

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

# Arguments
- `df`: The DataFrame to be written to a file.
- `path`: String as path where the .dta file will be created. If a file at this path already exists, it will be overwritten.

# Examples
```jldoctest 
julia> df = DataFrame(AA=["sav", "por"], AB=[10.1, 10.2]);

julia> write_sas(df, "test.sas7bdat")
2×2 ReadStatTable:
 Row │     AA        AB 
     │ String  Float64? 
─────┼──────────────────
   1 │    sav      10.1
   2 │    por      10.2

julia> write_sas(df, "test.xpt")
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

# Arguments
- `df`: The DataFrame to be written to a file.
- `path`: String as path where the .dta file will be created. If a file at this path already exists, it will be overwritten.

# Examples
```jldoctest 
julia> df = DataFrame(AA=["sav", "por"], AB=[10.1, 10.2]);

julia> write_dta(df, "test.dta")
2×2 ReadStatTable:
 Row │     AA        AB 
     │ String  Float64? 
─────┼──────────────────
   1 │    sav      10.1
   2 │    por      10.2
```
"""

const docstring_write_arrow =
"""
    write_arrow(df, path)
Write a DataFrame to an Arrow (.arrow) file.
# Arguments
- `df`: The DataFrame to be written to a file.
- `path`: String as path where the .dta file will be created. If a file at this path already exists, it will be overwritten.
# Examples
```jldoctest 
julia> df = DataFrame(AA=["Arr", "ow"], AB=[10.1, 10.2]);

julia> write_arrow(df , "test.arrow");
```
"""

const docstring_read_arrow =
"""
    read_arrow(df, path)
Read an Arrow file (.arrow) to a DataFrame.
# Arguments
- `df`: The DataFrame to be written to a file.
- `path`: String as path where the .dta file will be created. If a file at this path already exists, it will be overwritten.
- `skip`: Number of initial lines to skip before reading data. Default is 0.
- `n_max`: Maximum number of rows to read. Default is Inf (read all rows).
- `col_select`: Optional vector of symbols or strings to select which columns to load.
# Examples
```jldoctest 
julia> df = DataFrame(AA=["Arr", "ow"], AB=[10.1, 10.2]);

julia> write_arrow(df , "test.arrow");

julia> read_arrow("test.arrow")
2×2 DataFrame
 Row │ AA      AB      
     │ String  Float64 
─────┼─────────────────
   1 │ Arr        10.1
   2 │ ow         10.2
```
"""

const docstring_write_parquet =
"""
    write_parquet(df, )
Write a DataFrame to an Parquet (.parquet) file.
# Arguments
- `df`: The DataFrame to be written to a file.
- `path`: String as path where the .dta file will be created. If a file at this path already exists, it will be overwritten.

# Examples
```jldoctest 
julia> df = DataFrame(AA=["Par", "quet"], AB=[10.1, 10.2]);

julia> write_parquet(df, "test.parquet");
```
"""

const docstring_read_parquet =
"""
    read_parquet(path)
Read a Paquet File (.parquet) to a DataFrame.
# Arguments
- `path`: Path or vector of paths or URLs to parquet file to be read 
- `col_names`: Indicates if the first row of the CSV is used as column names. Can be true, false, or an array of strings. Default is true.
- `skip`: Number of initial lines to skip before reading data. Default is 0.
- `n_max`: Maximum number of rows to read. Default is Inf (read all rows).
- `col_select`: Optional vector of symbols or strings to select which columns to load.

# Examples
```jldoctest 
julia> df = DataFrame(AA=["Par", "quet"], AB=[10.1, 10.2]);

julia> write_parquet(df, "test.parquet");

julia> read_parquet("test.parquet")
2×2 DataFrame
 Row │ AA      AB      
     │ String  Float64 
─────┼─────────────────
   1 │ Par        10.1
   2 │ quet       10.2
```
"""

const docstring_read_file =
"""
    read_files(path; args)
Generic file reader that automatically detects type and dispatches the appropriate read function. 

# Arguments
- `path` : a string with the file path to read
- `args` : additional arguments supported for that specific file type are given as they normally would be 
# Examples
```jldoctest 
julia> df = DataFrame(ID = 1:5, Name = ["Alice", "Bob", "Charlie", "David", "Eva"], Score = [88, 92, 77, 85, 95]);

julia> write_parquet(df, "test.parquet");

julia> read_file("test.parquet")
5×3 DataFrame
 Row │ ID     Name     Score 
     │ Int64  String   Int64 
─────┼───────────────────────
   1 │     1  Alice       88
   2 │     2  Bob         92
   3 │     3  Charlie     77
   4 │     4  David       85
   5 │     5  Eva         95
```
"""

const docstring_write_file =
"""
    write_files(df, path; args)
Generic file writer that automatically detects type and dispatches the appropriate read function. 

# Arguments
- `df` : Data frame to be exported
- `path` : a string with the file path to for the location of resulting file
- `args` : additional arguments supported for that specific file type are given as they normally would be 

# Examples
```jldoctest 
julia> df = DataFrame(ID = 1:5, Name = ["Alice", "Bob", "Charlie", "David", "Eva"], Score = [88, 92, 77, 85, 95]);

julia> write_file(df, "test.parquet");

julia> read_file("test.parquet")
5×3 DataFrame
 Row │ ID     Name     Score 
     │ Int64  String   Int64 
─────┼───────────────────────
   1 │     1  Alice       88
   2 │     2  Bob         92
   3 │     3  Charlie     77
   4 │     4  David       85
   5 │     5  Eva         95
```
"""

const docstring_read_rdata =
"""
    read_rdata(path)
Read `.rdata` and `.rds` files as DataFrame. `.rdata` files will result in a `Dict`. Dataframes can then be selected with `result["name"]`

# Arguments
- `path`: A string with the file location. This does not yet support reading from URLs. 
"""

const docstring_list_files =
"""
    list_files(path = "", pattern = "")
List all files in a directory that match a given pattern.

# Arguments
- `path`: The directory path to list files from. Defaults to an empty string.
- `pattern`: A string pattern to filter the files. Defaults to an empty string, matching all files. ie `.csv` will only return files ending in .csv

# Examples
- `list_files("/path/to/folder/", ".csv")`
"""

const docstring_connect_gsheet = 
"""
    connect_gsheet(client_id::String, client_secret::String; redirect_uri::String = "http://localhost:8081")

Connects to Google Sheets API by obtaining an access token using OAuth 2.0 authorization flow.
To obtain the credentials, go to the Google Cloud Console -> APIs and Services -> Credentials -> Create Credentials -> Create OAuth Client ID -> Desktop App. 
This will contain the `client_id` and `client_secret`

# Arguments
- `client_id::String`: The client ID obtained from the Google Cloud Console.
- `client_secret::String`: The client secret obtained from the Google Cloud Console.
- `redirect_uri::String`: The URI to which the authorization server will redirect the user after granting access. Defaults to "http://localhost:8081".

# Returns
- An instance of `GSheetAuth` containing the client ID, client secret, redirect URI, and access token.

# Example
```julia
julia> connect_gsheet("your_client_id", "your_client_secret")
```
"""

const docstring_read_gsheet = 
"""
    read_gsheet(spreadsheet_id::String; 
                 sheet::String="Sheet1", 
                 range::String="", 
                 col_names::Bool=true, 
                 skip::Int=0, 
                 n_max::Int=1000, 
                 col_select=nothing, 
                 missing_value::String="")

Read data from a Google Sheet into a DataFrame.

# Arguments
- `spreadsheet_id::String`: The unique identifier of the Google Sheet or the full URL.
- `sheet::String`: The name of the sheet to read from. Defaults to "Sheet1".
- `range::String`: The range of cells to read (e.g., "A1:D10"). Defaults to an empty string, which reads the entire sheet.
- `col_names::Bool`: Indicates whether the first row should be used as column names. Defaults to true.
- `skip::Int`: Number of rows to skip before starting to read data. Defaults to 0.
- `n_max::Int`: Maximum number of rows to read after skipping. Defaults to Inf (read all available rows).
- `col_select`: List of column names or indices to select specific columns. Defaults to nothing (all columns).
- `missing_value::String`: Value to represent missing data. Defaults to an empty string.

# Examples
```julia
julia> connect_gsheet("your_client_id", "your_client_secret")

julia> public_sheet = "https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit?gid=0#gid=0";

julia> read_gsheet(public_sheet, sheet="Class Data", n_max=5)
5×6 DataFrame
 Row │ Student Name  Gender  Class Level   Home State  Major    Extracurricular Activity 
     │ String        String  String        String      String   String                   
─────┼───────────────────────────────────────────────────────────────────────────────────
   1 │ Alexandra     Female  4. Senior     CA          English  Drama Club
   2 │ Andrew        Male    1. Freshman   SD          Math     Lacrosse
   3 │ Anna          Female  1. Freshman   NC          English  Basketball
   4 │ Becky         Female  2. Sophomore  SD          Art      Baseball
   5 │ Benjamin      Male    4. Senior     WI          English  Basketball
```
"""

const docstring_write_gsheet = 
"""
    write_gsheet(data::DataFrame, spreadsheet_id::String; sheet::String="Sheet1", range::String="", missing_value::String = "", append::Bool = true)

Writes the contents of a DataFrame to a specified Google Sheets spreadsheet.

# Arguments
- `data::DataFrame`: The DataFrame containing the data to be written to Google Sheets.
- `spreadsheet_id::String`: The ID of the Google Sheets spreadsheet or the full URL containing the ID.
- `sheet::String`: The name of the sheet within the spreadsheet where the data will be written. Defaults to "Sheet1".
- `range::String`: The range in the sheet where the data will be written. If empty, defaults to "A1".
- `missing_value::String`: The value to replace missing entries in the DataFrame. Defaults to an empty string.
- `append::Bool`: If true, appends the data to the existing data in the sheet. If false, overwrites the existing data. Defaults to true.

# Examples
```
julia> df = DataFrame(A=1:5, B=["a", missing, "c", "d", "e"], C=[1.1, 2.2, 3.3, 4.4, 5.5]);

julia> write_gsheet(df, full, sheet = "sheet2", append = false)
```
"""

const docstring_read_json  =
"""
    read_json(path::String; null = missing, convertMixedNumberTypes::Bool = true) 

Read data from a JSON file into a DataFrame

# Arguments
- `path::String`: A file name or a URL to the JSON file
- `null`: Determines what data type a JSON null should be
- `convertMixedNumberTypes::Bool`: When parsing numers in JSON, they can be interpreted as Float64 or Int64, setting this flag to true, means mixed numers (in the same column) will be interpreted as Float64

# Examples
```julia

julia> df = read_json("https://raw.githubusercontent.com/vega/vega-datasets/refs/heads/main/data/movies.json")
3201×16 DataFrame
  Row │ Director         Worldwide Gross  Running Time min  US DVD Sales  Source                        Distributor  ⋯
      │ String?          Int64?           Int64?            Int64?        String?                       String?      ⋯
──────┼───────────────────────────────────────────────────────────────────────────────────────────────────────────────
    1 │ missing                   146083           missing       missing  missing                       Gramercy     ⋯
    2 │ missing                    10876           missing       missing  missing                       Strand
  ⋮   │        ⋮                ⋮                ⋮               ⋮                     ⋮                        ⋮    ⋱
 3200 │ Martin Campbell        141475336               129       missing  Remake                        Sony Picture
 3201 │ Martin Campbell        233700000               136       missing  Remake                        Sony Picture
```
"""


const docstring_write_json  =
"""
     write_json(df::DataFrame, path::String;JSONObjectVector::Bool=true)

     Writes the contents of a DataFrame to a specified JSON file

# Arguments
- `df::DataFrame`: The DataFrame containing the data to be written to a JSON file
- `path::String`: Path to the local JSON file to be written
- `JSONObjectVector::Bool`: Determines what JSON formatat to write, true means writing as a vector of JSON Objects, false writes as JSON arrays

# Examples
```
julia> df = DataFrame(A=1:5, B=["a", missing, "c", "d", "e"], C=[1.1, 2.2, 3.3, 4.4, 5.5]);

julia> write_json(df, "data.json")
```
"""