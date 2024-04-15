# Parquet file reading and writing is powered by Parquet2.jl
# ## `read_parquet`
# `read_parquet(path; col_names=true, skip=0, n_max=Inf, col_select=nothing)`

# This function reads a Parquet (.parquet) file into a DataFrame. The arguments are:

# - `path`: The path to the .parquet file.
# - `col_names`: Indicates if the first row of the file is used as column names. Default is `true`.
# - `skip`: Number of initial rows to skip before reading data. Default is 0.
# - `n_max`: Maximum number of rows to read. Default is `Inf` (read all rows).
# - `col_select`: Optional vector of symbols or strings to select which columns to load. Default is `nothing` (load all columns).

# ## `write_parquet` 
# `write_parquet(df, path)`

# This function writes a DataFrame to a Parquet (.parquet) file. The arguments are:

# - `df`: The DataFrame to be written to a file.
# - `path`: The path where the .parquet file will be created. If a file at this path already exists, it will be overwritten.
# - Additional arguments for writing parquet files are not outlined here, but should be available through the same interface of `Parquet2.writefile`. Refer to [documentation](https://expandingman.gitlab.io/Parquet2.jl/#Writing-Data) at their page for further explanation.