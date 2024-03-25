module TidierFiles

using CSV
using DataFrames
using XLSX
using Dates #bc XLSX type parsing does not seem to be working so i made some auto parsers for read_excel 
using HTTP
using ReadStatTables

export read_csv, write_csv, read_tsv, write_tsv, read_table, write_table, read_delim, read_excel, write_excel, 
 read_fwf, write_fwf, fwf_empty, fwf_positions, fwf_positions, read_sav, read_sas, read_dta, write_sav, write_sas, 
 write_dta
 
include("fwf.jl")
include("xlfiles.jl")
include("statsfiles.jl")
include("docstrings.jl")


"""
$docstring_read_csv
"""
function read_csv(file;
                  delim=',',
                  col_names=true,
                  skip=0,
                  n_max=Inf,
                  comment=nothing,
                  missingstring="",
                  escape_double=true,
                  ntasks::Int = Threads.nthreads(),  # Default ntasks value
                  num_threads::Union{Int, Nothing}=nothing) # Optional num_threads

    # Use num_threads if provided, otherwise stick with ntasks
    effective_ntasks = isnothing(num_threads) ? ntasks : num_threads
    
    # Convert n_max from Inf to Nothing for compatibility with CSV.File's limit argument
    limit = isinf(n_max) ? nothing : Int(n_max)

    # Calculate skipto and header correctly
    skipto = skip + (col_names === true ? 1 : 0)

    # Prepare arguments for CSV.read, including the effective number of tasks to use
    read_options = (
        delim = delim,
        header = col_names === true ? 1 : 0,
        skipto = skipto + 1,
        footerskip = 0,
        limit = limit,
        comment = comment,
        missingstring = missingstring,
        escapechar = escape_double ? '"' : '\\',
        quotechar = '"',
        normalizenames = false,
        ntasks = effective_ntasks > 1
    )


    # Filter options to remove any set to `nothing`
   # clean_options = Dict{Symbol,Any}(filter(p -> !isnothing(p[2]), read_options))

    # Check if the file is a URL and read accordingly
    if startswith(file, "http://") || startswith(file, "https://")
        # Fetch the content from the URL
        response = HTTP.get(file)
        
        # Ensure the request was successful
        if response.status != 200
            error("Failed to fetch the CSV file: HTTP status code ", response.status)
        end

        # Read the CSV data from the fetched content using cleaned options
        df = CSV.File(IOBuffer(response.body); read_options...) |> DataFrame
    else
        # Read from a local file using cleaned options
        df = CSV.File(file; read_options...) |> DataFrame
    end

    return df
end


"""
$docstring_write_csv
"""
function write_csv(
    x::DataFrame,
    file::String;
    na::String = "NA",
    append::Bool = false,
    col_names::Bool = true,
    eol::String = "\n",
    num_threads::Int = Threads.nthreads())

    # Configure threading
    CSV.write(
        file,
        x,
        append = append,
        writeheader = col_names && !append,
        nastring = na,
        newline = eol,
        threaded = num_threads > 1    )
end

"""
$docstring_read_tsv
"""
function read_tsv(file;
                  delim='\t',
                  col_names=true,
                  skip=0,
                  n_max=Inf,
                  comment=nothing,
                  missingstring="",
                  escape_double=true,
                  ntasks::Int = Threads.nthreads(),  # Default ntasks value
                  num_threads::Union{Int, Nothing}=nothing) # Optional num_threads
                 
    # Use num_threads if provided, otherwise stick with ntasks
    effective_ntasks = isnothing(num_threads) ? ntasks : num_threads
    
    # Convert n_max from Inf to Nothing for compatibility with CSV.File's limit argument
    limit = isinf(n_max) ? nothing : Int(n_max)

    # Calculate skipto and header correctly
    skipto = skip + (col_names === true ? 1 : 0)

    # Prepare arguments for CSV.read, including the effective number of tasks to use
    read_options = (
        delim = delim,
        header = col_names === true ? 1 : 0,
        skipto = skipto + 1,
        footerskip = 0,
        limit = limit,
        comment = comment,
        missingstring = missingstring,
        escapechar = escape_double ? '"' : '\\',
        quotechar = '"',
        normalizenames = false,
        ntasks = effective_ntasks > 1
    )
    # Read the TSV file into a DataFrame
    if startswith(file, "http://") || startswith(file, "https://")
        # Fetch the content from the URL
        response = HTTP.get(file)
        
        # Ensure the request was successful
        if response.status != 200
            error("Failed to fetch the CSV file: HTTP status code ", response.status)
        end

        # Read the CSV data from the fetched content using cleaned options
        df = CSV.File(IOBuffer(response.body); read_options...) |> DataFrame
    else
        # Read from a local file using cleaned options
        df = CSV.File(file; read_options...) |> DataFrame
    end
    return df
end

"""
$docstring_write_tsv
"""
function write_tsv(
    x::DataFrame,
    file::String;
    na::String = "",
    append::Bool = false,
    col_names::Bool = true,
    eol::String = "\n",
    num_threads::Int = Threads.nthreads())

    # Write DataFrame to TSV
    CSV.write(
        file,
        x,
        delim = '\t',  # Use tab as the delimiter for TSV
        append = append,
        writeheader = col_names && !append,
        nastring = "",
        newline = eol,
        threaded = num_threads > 1)
end

"""
$docstring_read_delim
"""
function read_delim(file;
                  delim='\t',
                  col_names=true,
                  skip=0,
                  n_max=Inf,
                  comment=nothing,
                  missingstring="",
                  escape_double=true,
                  ntasks::Int = Threads.nthreads(),  # Default ntasks value
                  num_threads::Union{Int, Nothing}=nothing) # Optional num_threads

    # Use num_threads if provided, otherwise stick with ntasks
    effective_ntasks = isnothing(num_threads) ? ntasks : num_threads
    
    # Convert n_max from Inf to Nothing for compatibility with CSV.File's limit argument
    limit = isinf(n_max) ? nothing : Int(n_max)

    # Calculate skipto and header correctly
    skipto = skip + (col_names === true ? 1 : 0)

    # Prepare arguments for CSV.read, including the effective number of tasks to use
    read_options = (
        delim = delim,
        header = col_names === true ? 1 : 0,
        skipto = skipto + 1,
        footerskip = 0,
        limit = limit,
        comment = comment,
        missingstring = missingstring,
        escapechar = escape_double ? '"' : '\\',
        quotechar = '"',
        normalizenames = false,
        ntasks = effective_ntasks > 1
    )
    # Filter options to remove any set to `nothing`
  #  clean_options = Dict{Symbol,Any}(filter(p -> !isnothing(p[2]), read_options))

    # Read the file into a DataFrame
    if startswith(file, "http://") || startswith(file, "https://")
        # Fetch the content from the URL
        response = HTTP.get(file)
        
        # Ensure the request was successful
        if response.status != 200
            error("Failed to fetch the CSV file: HTTP status code ", response.status)
        end

        # Read the CSV data from the fetched content using cleaned options
        df = CSV.File(IOBuffer(response.body); read_options...) |> DataFrame
    else
        # Read from a local file using cleaned options
        df = CSV.File(file; read_options...) |> DataFrame
    end
    return df
end

"""
$docstring_read_table
"""
function read_table(file; 
        col_names=true, 
        skip=0, 
        n_max=Inf, 
        comment=nothing, 
        missingstring="",
        kwargs...)
    # Preprocess the file to replace sequences of spaces with a single space
    processed_lines = open(file, "r") do io
        lines = readlines(io)
        # Apply preprocessing steps: trim and reduce whitespace
        lines = map(line -> replace(line, r"\s+" => " "), lines)
        
        # Skip lines if `skip` is specified
        if skip > 0
            lines = lines[(skip+1):end]
        end
        
        # Handle `n_max` to limit the number of lines read
        if !isinf(n_max)
            lines = lines[1:min(n_max, length(lines))]
        end
        
        # If a comment character is specified, filter out commented lines
        if !isnothing(comment)
            lines = filter(line -> !startswith(line, comment), lines)
        end

        lines
    end
    
    # Convert processed lines into a temporary DataFrame using CSV.File with space as the delimiter
    df = CSV.File(IOBuffer(join(processed_lines, "\n")); 
                  delim=' ', 
                  header=col_names, 
                  missingstring=missingstring, 
                  kwargs...) |> DataFrame

    return df
end


"""
$docstring_write_table
"""
function write_table(
    x::DataFrame,
    file::String;
    delim::Char = '\t',  # Default to TSV, but allow flexibility
    na::String = "",
    append::Bool = false,
    col_names::Bool = true,
    eol::String = "\n",
    num_threads::Int = Threads.nthreads())
    
    # Write DataFrame to a file with the specified delimiter
    CSV.write(
        file,
        x,
        delim = delim,  # Flexible delimiter based on argument
        append = append,
        writeheader = col_names && !append,
        nastring = na,
        newline = eol,
        threaded = num_threads > 1)
end

end