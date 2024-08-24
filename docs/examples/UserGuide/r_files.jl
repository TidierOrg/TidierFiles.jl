# Reading .rds and .rdata files is made possible via RData.jl. There is currently no write support, nor is there url support.

# To read the file, simply pass the path to `read_rdata` or `read_file`. There is a small difference between .rds and .rdata files. 
# .rdata files will contain a dict of the table name and the data frame. There can be multiple entries in one .rdata file. To access the data frame, you must pass the name of the dict to the object.

# ```julia
# using TidierFiles 
# file = read_rdata("path.rdata) # or read_file("path.rdata)
# df = file["entry_name"]
# ```

# This is in contrast to .rds files which will contain one data frame.
# ```julia
# df = read_rdata("path.rds)
# ```