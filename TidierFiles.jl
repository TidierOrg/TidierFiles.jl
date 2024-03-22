using CSV
using DataFrames

csv_path ="/Users/danielrizk/Downloads/TidierDB.jl/mtcars.csv"





function read_csv(file;
    delim=',',
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

        # Prepare arguments for CSV.read
        read_options = Dict(
        :delim => delim,
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

        # Read the CSV file into a DataFrame
        df = CSV.read(file, DataFrame; clean_options...)

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


df = DataFrames.DataFrame(integers=[1, 2, 3, 4], strings=["Hey", "You", "Out", "There"], floats=[10.2, 20.3, 30.4, 40.5], dates=[Date(2018,2,20), Date(2018,2,21), Date(2018,2,22), Date(2018,2,23)], times=[Dates.Time(19,10), Dates.Time(19,20), Dates.Time(19,30), Dates.Time(19,40)], datetimes=[Dates.DateTime(2018,5,20,19,10), Dates.DateTime(2018,5,20,19,20), Dates.DateTime(2018,5,20,19,30), Dates.DateTime(2018,5,20,19,40)])
XLSX.writetable("output_table.xlsx", df, overwrite=true, sheetname="report", anchor_cell="B2")
# Read the rest of the data starting from the second row
data = XLSX.readdata(xl_path, "Sheet1", "A2:I174")

# Create the DataFrame using the read column names and data
df = DataFrame(data, Symbol.(column_names))
read_excel("output_table.xlsx")
read_excel(xl_path)
XLSX.writetable

mtcarsastsv = read_csv(csv_path)
write_tsv(mtcarsastsv, "/Users/danielrizk/Downloads/mtcars.tsv"  )
read_tsv("/Users/danielrizk/Downloads/mtcars.tsv", missingstring = " test")
read_csv("/Users/danielrizk/Downloads/mtcars.tsv")
write_csv(mtcarsastsv, "/Users/danielrizk/Downloads/mtcars.csv" , append = true)
read_csv("/Users/danielrizk/Downloads/mtcars.csv", missingstring=["4", "1", ""])

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
function guess_widths_auto(lines)
    max_length = maximum(length, lines)
    # Initialize arrays to hold counts of non-space to space transitions (potential column ends)
    transitions = zeros(Int, max_length)
    
    for line in lines
        # Note transitions from non-space to space, indicating potential column boundaries
        for pos in 2:length(line)
            if line[pos] == ' ' && line[pos - 1] != ' '
                transitions[pos] += 1
            end
        end
    end

    # Determine likely column boundaries by finding transitions present in a high percentage of lines
    threshold = length(lines) * 0.7
    likely_boundaries = findall(x -> x > threshold, transitions)

    # If no boundaries are detected, return an empty result
    if isempty(likely_boundaries)
        return []
    end

    # The first column starts at position 1
    start_positions = [1]
    # Calculate widths based on differences between consecutive likely boundaries
    for i in 2:length(likely_boundaries)
        push!(start_positions, likely_boundaries[i-1] + 1)
    end

    # Add a start position for the last column
    push!(start_positions, likely_boundaries[end] + 1)

    # Calculate widths from start positions
    widths = diff(append!(start_positions, max_length + 1)) .- 1

    return zip(start_positions, widths)
end

function read_fwf(file; widths=nothing, col_names=nothing, skip=0, n_max=Inf, na="NA", trim_ws=true)
    open(file, "r") do io
        lines = readlines(io)
        relevant_lines = lines[(skip + 1):end]

        if isnothing(widths)
            sample_lines = relevant_lines[1:min(100, length(relevant_lines))]  # Use a sample of 100 lines to guess widths
            widths = guess_widths(sample_lines)
        end
        
        if !isinf(n_max)
            relevant_lines = relevant_lines[1:n_max]
        end

        data = [String[] for _ in 1:length(widths)]
        
        for line in relevant_lines
            for (i, (start, width)) in enumerate(widths)
                field = SubString(line, start, min(start + width - 1, length(line)))
                if trim_ws
                    field = strip(field)
                end
                push!(data[i], field == na ? missing : field)
            end
        end

        if isnothing(col_names)
            col_names = Symbol.(:Column, 1:length(widths))
        elseif col_names === true
            col_names = Symbol.(data[1])
            data = data[2:end]
        else
            col_names = Symbol.(col_names)
        end

        df = DataFrame(data, col_names)
        return df
    end
    
    
end



