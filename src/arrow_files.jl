"""
$docstring_read_arrow
"""
function read_arrow(data_file;
                    col_select=nothing,
                    skip=0,
                    n_max=Inf)
    # Determine if the file is a local file or a URL
    if startswith(data_file, "http://") || startswith(data_file, "https://")
        # Fetch the content from the URL
        response = HTTP.get(data_file)

        # Ensure the request was successful
        if response.status != 200
            error("Failed to fetch the Arrow file: HTTP status code ", response.status)
        end

        # Use the content fetched from the URL as an IOBuffer for reading
        file_to_read = IOBuffer(response.body)
    else
        # Use the local file path
        file_to_read = data_file
    end

    # Load the Arrow file into a DataFrame directly
    df = DataFrame(Arrow.Table(file_to_read); copycols=false)

    # Apply column selection if specified
    if !isnothing(col_select)
        df = select(df, col_select)  # Use the select function for safe column selection
    end

    # Apply row limit and skip if specified
    if !isinf(n_max) || skip > 0
        start_row = skip + 1
        end_row = !isinf(n_max) ? start_row + n_max - 1 : nrow(df)
        df = df[start_row:min(end_row, nrow(df)), :]
    end

    return df
end

"""
$docstring_write_arrow
"""
function write_arrow(tbl, file::String; append=false, compress=:lz4, alignment=8, 
                        dictencode=false, dictencodenested=false, denseunions=true, 
                        largelists=false, maxdepth=6, num_threads=Threads.nthreads())


        # Prepare keyword arguments for Arrow.write
        write_options = Dict(
        # :compress => compressor,
            :alignment => alignment,
            :dictencode => dictencode,
            :dictencodenested => dictencodenested,
            :denseunions => denseunions,
            :largelists => largelists,
            :maxdepth => maxdepth,
            :ntasks => num_threads
        )

        # Write the data to file
        if append
            # Open the file in append mode and write
            open(file, "a") do io
                Arrow.write(io, tbl; write_options..., file=true)
            end
        else
            # Write directly to file, creating or overwriting by default
            Arrow.write(file, tbl; write_options...)
        end
end