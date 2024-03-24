using CSV
using DataFrames
using XLSX, Dates #bc XLSX type parsing does not seem to be working so i made some auto parsers for read_excel 
csv_path ="/Users/danielrizk/Downloads/TidierDB.jl/mtcars.csv"






using CSV, DataFrames, HTTP

function read_csv(file;
                  delim=',',
                  col_names=true,
                  skip=0,
                  n_max=Inf,
                  comment=nothing,
                  missingstring="",
                  escape_double=true,
                  col_types=nothing)
    # Convert n_max from Inf to Nothing for compatibility with CSV.File's limit argument
    limit = isinf(n_max) ? nothing : Int(n_max)

    # Adjust arguments for CSV.File
    header_arg = col_names === true ? 1 : 0
    datarow = skip + 1

    # Prepare arguments for CSV.File
    read_options = Dict(
        :delim => delim,
        :header => header_arg,
        :datarow => datarow,
        :limit => limit,
        :comment => comment,
        :missingstring => missingstring,
        :quotechar => '"',
        :escapechar => escape_double ? '"' : '\\',
        :normalizenames => true
    )

    # Filter options to remove any set to `nothing`
    clean_options = Dict{Symbol,Any}(filter(p -> !isnothing(p[2]), read_options))

    # Check if the file is a URL and read accordingly
    if startswith(file, "http://") || startswith(file, "https://")
        # Fetch the content from the URL
        response = HTTP.get(file)
        
        # Ensure the request was successful
        if response.status != 200
            error("Failed to fetch the CSV file: HTTP status code ", response.status)
        end

        # Read the CSV data from the fetched content using cleaned options
        df = CSV.File(IOBuffer(response.body); clean_options...) |> DataFrame
    else
        # Read from a local file using cleaned options
        df = CSV.File(file; clean_options...) |> DataFrame
    end

    return df
end


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

read_csv(csv_path)  

read_csv(csv_path)  
 xf["Sheet1"]
using XLSX


xl_path = "/Users/danielrizk/Downloads/Assignment_Datasets/import.xlsx"


df = DataFrame(integers=[1, 2, 3, 4], strings=["This", "Package makes", "File reading/writing", "even smoother"], floats=[10.2, 20.3, 30.4, 40.5], dates=[Date(2018,2,20), Date(2018,2,21), Date(2018,2,22), Date(2018,2,23)], times=[Dates.Time(19,10), Dates.Time(19,20), Dates.Time(19,30), Dates.Time(19,40)], datetimes=[Dates.DateTime(2018,5,20,19,10), Dates.DateTime(2018,5,20,19,20), Dates.DateTime(2018,5,20,19,30), Dates.DateTime(2018,5,20,19,40)])

mtcarsastsv = read_csv(csv_path)
write_tsv(mtcarsastsv, "/Users/danielrizk/Downloads/mtcars.tsv"  )
read_tsv("/Users/danielrizk/Downloads/mtcars.tsv", missingstring = " test")
read_csv("/Users/danielrizk/Downloads/mtcars.tsv")
read_delim("/Users/danielrizk/Downloads/mtcars.tsv", delim = "\t")
read_delim("/Users/danielrizk/Downloads/mtcars.csv", delim = ",")

read_csv("/Users/danielrizk/Downloads/mtcars.tsv")
df = DataFrame(integers=[1, 2, 3, 4], strings=["This", "Package makes", "File reading/writing", "even smoother"], floats=[10.2, 20.3, 30.4, 40.5], dates=[Date(2018,2,20), Date(2018,2,21), Date(2018,2,22), Date(2018,2,23)], times=[Dates.Time(19,10), Dates.Time(19,20), Dates.Time(19,30), Dates.Time(19,40)], datetimes=[Dates.DateTime(2018,5,20,19,10), Dates.DateTime(2018,5,20,19,20), Dates.DateTime(2018,5,20,19,30), Dates.DateTime(2018,5,20,19,40)])
write_csv(df, "/Users/danielrizk/Downloads/testing.csv" , col_names= true)
read_csv("/Users/danielrizk/Downloads/testing.csv", missingstring=["40.5", "10.2"])

using DataFrames
tsv_path = "/Users/danielrizk/Downloads/pythonsratch/UPDATED_NLP_COURSE/TextFiles/moviereviews.tsv"


function read_tsv(file;
    col_names=true,
    skip=0,
    n_max=Inf,
    comment=nothing,
    missingstring="",
    escape_backslash=false,
    escape_double=true,
    col_types=nothing,
    trim_ws=true)
    # Convert n_max from Inf to Nothing for compatibility with CSV.read's limit argument
    limit = isinf(n_max) ? nothing : Int(n_max)

    # Calculate skipto and header correctly
    if col_names === true
        header = skip + 1  # Use the first row after skipping as header
        skipto = skip + 2  # Data starts after the header
    else
        header = false
        skipto = skip + 1  # Start reading data immediately if no header
    end

    # Adjust header for CSV.read
    header_arg = col_names === true ? header : 0

    # Prepare arguments for CSV.read, setting delimiter to tab
    read_options = Dict(
    :delim => '\t',  # This is the key change for TSV
    :header => header_arg,
    :skipto => skipto,
    :footerskip => 0,
    :limit => limit,
    :comment => comment,
    :missingstring => missingstring, 
    :escapechar => escape_double ? '"' : (escape_backslash ? '\\' : nothing),
    :quotechar => '"',
    :normalizenames => false
    )

    # Filter options to remove any set to `nothing`
    clean_options = Dict{Symbol,Any}(filter(p -> !isnothing(p[2]), read_options))

    # Read the TSV file into a DataFrame
    df = CSV.read(file, DataFrame; clean_options...)

    return df
end

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

read_tsv("/Users/danielrizk/opt/anaconda3/pkgs/gensim-4.1.2-py39he9d5cce_0/lib/python3.9/site-packages/gensim/test/test_data/wordsim353.tsv")
read_tsv(tsv_path,col_names = false)




using DataFrames
read_fwf("/Users/danielrizk/Downloads/fwftest.txt")
read_table("/Users/danielrizk/Downloads/fwftest.txt", col_names= false)




df1 = DataFrames.DataFrame(COL1=[10,20,30], COL2=["First", "Second", "Third"])


function read_delim(file;
    delim=',',  # Add delim as a function parameter with default value ','
    col_names=true,
    skip=0,
    n_max=Inf,
    comment=nothing,
    missingstring="",
    escape_backslash=false,
    escape_double=true,
    col_types=nothing,
    trim_ws=true)
    # Convert n_max from Inf to Nothing for compatibility with CSV.read's limit argument
    limit = isinf(n_max) ? nothing : Int(n_max)

    # Calculate skipto and header correctly
    skipto = skip + (col_names === true ? 1 : 0)

    # Prepare arguments for CSV.read
    read_options = Dict(
        :delim => delim,  # Use the delim parameter
        :header => col_names ? skipto : false,
        :skipto => skipto + 1,
        :footerskip => 0,
        :limit => limit,
        :comment => comment,
        :missingstring => missingstring,
        :escapechar => escape_double ? '"' : (escape_backslash ? '\\' : nothing),
        :quotechar => '"',
        :normalizenames => false,
        :types => col_types,
        :stripwhitespace => trim_ws
    )

    # Filter options to remove any set to `nothing`
    clean_options = Dict{Symbol,Any}(filter(p -> !isnothing(p[2]), read_options))

    # Read the file into a DataFrame
    df = CSV.read(file, DataFrame; clean_options...)

    return df
end


using HTTP
function read_csv(file; kwargs...)
    # Check if the file is a URL
    if startswith(file, "http://") || startswith(file, "https://")
        # Fetch the content from the URL
        response = HTTP.get(file)
        
        # Ensure the request was successful
        if response.status != 200
            error("Failed to fetch the CSV file: HTTP status code ", response.status)
        end

        # Read the CSV data from the fetched content
        df = CSV.File(IOBuffer(response.body); kwargs...) |> DataFrame
    else
        # Read from a local file
        df = CSV.read(file, DataFrame; kwargs...)
    end

    return df
end

read_csv("https://github.com/tidyverse/readr/raw/main/inst/extdata/mtcars.csv", skip = 4, missingstring = ["1"])

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
df
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

write_table(df, "/Users/danielrizk/Downloads/fwftest2.txt")
read_table( "/Users/danielrizk/Downloads/fwftest2.txt")
