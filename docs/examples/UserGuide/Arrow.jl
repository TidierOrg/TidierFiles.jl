# Arrow file reading and writing is powered by Arrow.jl
# ## `read_arrow`
# read_arrow(path; skip=0, n_max=Inf, col_select=nothing)

# This function reads a Parquet (.parquet) file into a DataFrame. The arguments are:

# - `path`: The path to the .parquet file.
# - `skip`: Number of initial rows to skip before reading data. Default is 0.
# - `n_max`: Maximum number of rows to read. Default is `Inf` (read all rows).
# - `col_select`: Optional vector of symbols or strings to select which columns to load. Default is `nothing` (load all columns).

# ## `write_arrow` 
# `write_arrow(df, path)`

# This function writes a DataFrame to a Parquet (.parquet) file. The arguments are:

# - `df`: The DataFrame to be written to a file.
# - `path`: The path where the .parquet file will be created. If a file at this path already exists, it will be overwritten.
# - Additional arguments for writing arrow files are not outlined here, but should be available through the same interface of `Arrow.write`. Refer to Arrow.jl [documentation](https://arrow.apache.org/julia/stable/manual/#Arrow.write) at their page for further explanation.