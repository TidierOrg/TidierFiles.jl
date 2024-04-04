# The functions for reading and writing stats files are made possible by ReadStatTables.jl

# ## reading stats files
# read_dta(filepath; encoding=nothing, col_select=nothing, skip=0, n_max=Inf, num_threads=1)
# read_sas(filepath; encoding=nothing, col_select=nothing, skip=0, n_max=Inf, num_threads=1)
# read_sav(filepath; encoding=nothing, col_select=nothing, skip=0, n_max=Inf, num_threads=1)

# These functions read data from Stata (.dta), SAS (.sas7bdat and .xpt), and SPSS (.sav and .por) files into a DataFrame. The arguments are:

# - `filepath`: The path to the file or a URL pointing to the file. If a URL is provided, the file will be downloaded and then read.
# - `encoding`: Optional; specifies the encoding of the input file. Default is the package's or function's default.
# - `col_select`: Optional; allows specifying a subset of columns to read. Can be a vector of column names or indices. Default is `nothing` (all columns are read).
# - `skip`: Number of rows to skip at the beginning of the file. Default is 0.
# - `n_max`: Maximum number of rows to read after skipping. Default is `Inf` (read all rows).
# - `num_threads`: Number of concurrent tasks or threads to use for processing. Default is 1.

# ## writing stats files
# write_sav(df, path)
# write_sas(df, path)
# write_dta(df, path)

# These functions write a DataFrame to SPSS (.sav or .por), SAS (.sas7bdat or .xpt), and Stata (.dta) files. The arguments are:

# - `df`: The DataFrame to be written to a file.
# - `path`: The path where the file will be created. If a file at this path already exists, it will be overwritten.