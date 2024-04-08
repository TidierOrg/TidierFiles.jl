"""
$docstring_read_sas
"""
function read_sas(data_file; 
    encoding=nothing, 
    col_select=nothing, 
    skip=0, 
    n_max=Inf,
    num_threads::Int = Threads.nthreads())  # Use num_threads for parallel reading

    # Determine if the file needs to be fetched from a URL
    if startswith(data_file, "http://") || startswith(data_file, "https://")
        # Fetch the content from the URL
        response = HTTP.get(data_file)
        
        # Ensure the request was successful
        if response.status != 200
            error("Failed to fetch the data file: HTTP status code ", response.status)
        end

        # Use the content fetched from the URL as an IOBuffer for reading
        file_to_read = IOBuffer(response.body)
    else
        # Use the local file path
        file_to_read = data_file
    end

    # Prepare the keyword arguments for readstat, including num_threads for parallel processing
    kwargs = Dict(
        :usecols => col_select,  # Select specific columns if provided
        :row_limit => n_max == Inf ? nothing : n_max,  # Convert Inf to nothing for unlimited
        :row_offset => skip,  # Skip the specified number of rows
        :ntasks => num_threads > 1 ? num_threads : nothing,  # Use num_threads for parallel reading if > 1
        # :convert_datetime => true,  # Assuming default behavior is to convert datetime
        :apply_value_labels => true,  # Apply value labels if available
        :file_encoding => encoding,  # Set file encoding if provided
        :handler_encoding => encoding != nothing ? encoding : "UTF-8"  # Set handler encoding, default to UTF-8
    )

    # Read the data file into a DataFrame
    df = DataFrame(ReadStatTables.readstat(file_to_read; kwargs...))
    
    return df
end

"""
$docstring_read_sav
"""
function read_sav(data_file; 
    encoding=nothing, 
    col_select=nothing, 
    skip=0, 
    n_max=Inf,
    num_threads::Int = Threads.nthreads())  # Use num_threads for parallel reading

    # Determine if the file needs to be fetched from a URL
    if startswith(data_file, "http://") || startswith(data_file, "https://")
        # Fetch the content from the URL
        response = HTTP.get(data_file)
        
        # Ensure the request was successful
        if response.status != 200
            error("Failed to fetch the data file: HTTP status code ", response.status)
        end

        # Use the content fetched from the URL as an IOBuffer for reading
        file_to_read = IOBuffer(response.body)
    else
        # Use the local file path
        file_to_read = data_file
    end

    # Prepare the keyword arguments for readstat, including num_threads for parallel processing
    kwargs = Dict(
        :usecols => col_select,  # Select specific columns if provided
        :row_limit => n_max == Inf ? nothing : n_max,  # Convert Inf to nothing for unlimited
        :row_offset => skip,  # Skip the specified number of rows
        :ntasks => num_threads > 1 ? num_threads : nothing,  # Use num_threads for parallel reading if > 1
        # :convert_datetime => true,  # Assuming default behavior is to convert datetime
        :apply_value_labels => true,  # Apply value labels if available
        :file_encoding => encoding,  # Set file encoding if provided
        :handler_encoding => encoding != nothing ? encoding : "UTF-8"  # Set handler encoding, default to UTF-8
    )

    # Read the data file into a DataFrame
    df = DataFrame(ReadStatTables.readstat(file_to_read; kwargs...))
    
    return df
end

"""
$docstring_read_dta
"""
function read_dta(data_file; 
    encoding=nothing, 
    col_select=nothing, 
    skip=0, 
    n_max=Inf,
    num_threads::Int = Threads.nthreads())  # Use num_threads for parallel reading

    # Determine if the file needs to be fetched from a URL
    if startswith(data_file, "http://") || startswith(data_file, "https://")
        # Fetch the content from the URL
        response = HTTP.get(data_file)
        
        # Ensure the request was successful
        if response.status != 200
            error("Failed to fetch the data file: HTTP status code ", response.status)
        end

        # Use the content fetched from the URL as an IOBuffer for reading
        file_to_read = IOBuffer(response.body)
    else
        # Use the local file path
        file_to_read = data_file
    end

    # Prepare the keyword arguments for readstat, including num_threads for parallel processing
    kwargs = Dict(
        :usecols => col_select,  # Select specific columns if provided
        :row_limit => n_max == Inf ? nothing : n_max,  # Convert Inf to nothing for unlimited
        :row_offset => skip,  # Skip the specified number of rows
        :ntasks => num_threads > 1 ? num_threads : nothing,  # Use num_threads for parallel reading if > 1
        # :convert_datetime => true,  # Assuming default behavior is to convert datetime
        :apply_value_labels => true,  # Apply value labels if available
        :file_encoding => encoding,  # Set file encoding if provided
        :handler_encoding => encoding != nothing ? encoding : "UTF-8"  # Set handler encoding, default to UTF-8
    )

    # Read the data file into a DataFrame
    df = DataFrame(ReadStatTables.readstat(file_to_read; kwargs...))
    
    return df
end


"""
$docstring_write_sas
"""
function write_sas(df::DataFrame, path::String)
    writestat(path, df);
end

"""
$docstring_write_sav
"""
function write_sav(df::DataFrame, path::String)
    return writestat(path, df);
end

"""
$docstring_write_dta
"""
function write_dta(df::DataFrame, path::String)
    return writestat(path, df);
end