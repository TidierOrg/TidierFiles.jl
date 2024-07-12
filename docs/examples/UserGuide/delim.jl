# The goal of reading and writing throughout TidierFiles.jl is to use consistent syntax. This functions on this page focus on delimited files and are powered by CSV.jl. 

using TidierFiles

# ## read_csv/tsv/delim

read_csv("https://raw.githubusercontent.com/TidierOrg/TidierFiles.jl/main/testing_files/csvtest.csv", skip = 2, n_max = 3, col_select = ["ID", "Score"], missingstring = ["4"])

#read_csv(file; delim=',', col_names=true, skip=0, n_max=Inf, comment=nothing, missingstring="", col_select=nothing, escape_double=true, col_types=nothing, num_threads=1)

#read_tsv(file; delim='\t', col_names=true, skip=0, n_max=Inf, comment=nothing, missingstring="", col_select=nothing, escape_double=true, col_types=nothing, num_threads=Threads.nthreads())

#read_delim(file; delim='\t', decimal = '.', groupmark = nothing col_names=true, skip=0, n_max=Inf, comment=nothing, missingstring="", col_select=nothing, escape_double=true, col_types=nothing, num_threads=Threads.nthreads())

#read_csv2(file; delim=';', decimal = ',', col_names=true, skip=0, n_max=Inf, comment=nothing, missingstring="", col_select=nothing, escape_double=true, col_types=nothing, num_threads=Threads.nthreads())

#These functions read a delimited file (CSV, TSV, or custom delimiter) into a DataFrame. The arguments are:

# - `file`: Path or vector of paths to the file(s) or a URL(s).
# - `delim`: Field delimiter. Default is ',' for `read_csv`, '\t' for `read_tsv` and `read_delim`.
# - `col_names`: Use first row as column names. Can be `true`, `false`, or an array of strings. Default is `true`.
# - `skip`: Number of lines to skip before reading data. Default is 0.
# - `n_max`: Maximum number of rows to read. Default is `Inf` (read all rows).
# - `comment`: Character indicating comment lines to ignore. Default is `nothing`.
# - `missingstring`: String(s) representing missing values. Default is `""`.
# - `col_select`: Optional vector of symbols or strings to select columns to load. Default is `nothing`.
# - `groupmark`: A symbol that separates groups of digits Default is `nothing`.
# - `decimal`: An ASCII Char argument that is used when parsing float values. Default is '.'.
# - `escape_double`: Interpret two consecutive quote characters as a single quote. Default is `true`.
# - `col_types`: Optional specification of column types. Default is `nothing` (types are inferred).
# - `num_threads`: Number of threads to use for parallel execution. Default is 1 for `read_csv` and the number of available threads for `read_tsv` and `read_delim`.

# The functions return a DataFrame containing the parsed data from the file.

# ## `write_csv` and `write_tsv`

# write_csv(x, file; missingstring="", append=false, col_names=true, eol="\n", num_threads=Threads.nthreads())

# write_tsv(x, file; missingstring="", append=false, col_names=true, eol="\n", num_threads=Threads.nthreads())

# These functions write a DataFrame to a CSV or TSV file. The arguments are:

# - `x`: The DataFrame to write.
# - `file`: The path to the output file.
# - `missingstring`: The string to represent missing values. Default is an empty string.
# - `append`: Whether to append to an existing file. Default is `false`.
# - `col_names`: Whether to write column names as the first line. Default is `true`.
# - `eol`: The end-of-line character. Default is `"\n"`.
# - `num_threads`: The number of threads to use for writing. Default is the number of available threads.

# ## `read_table`

# read_table(file; col_names=true, skip=0, n_max=Inf, comment=nothing, col_select=nothing, missingstring="", num_threads)

# This function reads a table from a whitespace-delimited file into a DataFrame. The arguments are:

# - `file`: The path to the file to read.
# - `col_names`: Whether the first non-skipped line contains column names. Default is `true`.
# - `skip`: Number of lines to skip before processing. Default is 0.
# - `n_max`: Maximum number of lines to read. Default is `Inf` (read all lines).
# - `comment`: Character or string indicating comment lines to ignore. Default is `nothing`.
# - `col_select`: Optional vector of symbols or strings to select columns to load. Default is `nothing`.
# - `missingstring`: The string representing missing values. Default is `""`.
# - `num_threads`: The number of threads to use for writing. Default is the number of available threads.

# ## `write_table`
# write_table(x, file; delim='\t', missingstring="", append=false, col_names=true, eol="\n", num_threads=Threads.nthreads())

# This function writes a DataFrame to a file with customizable delimiter and options. The arguments are:

# - `x`: The DataFrame to write.
# - `file`: The path to the output file.
# - `delim`: The field delimiter. Default is `'\t'` (tab-separated).
# - `missingstring`: The string to represent missing values. Default is `""`.
# - `append`: Whether to append to an existing file. Default is `false`.
# - `col_names`: Whether to write column names as the first line. Default is `true`.
# - `eol`: The end-of-line character. Default is `"\n"`.
# - `num_threads`: The number of threads to use for writing. Default is the number of available threads.