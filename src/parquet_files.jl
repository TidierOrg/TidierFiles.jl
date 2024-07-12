"""
$docstring_read_parquet
"""
function read_parquet(files;
                      col_select=nothing,
                      skip=0,
                      n_max=Inf,
                      col_names=true)

    # Normalize input to always be a vector of files
    file_list = (typeof(files) <: AbstractString) ? [files] : files

    # Initialize an empty DataFrame
    final_df = DataFrame()

    # Loop over files
    for data_file in file_list
        # Determine if the file is a local file or a URL
        if startswith(data_file, "http://") || startswith(data_file, "https://")
            # Fetch the content from the URL
            response = HTTP.get(data_file)

            # Ensure the request was successful
            if response.status != 200
                error("Failed to fetch the Parquet file: HTTP status code ", response.status)
            end

            # Use the content fetched from the URL as an IOBuffer for reading
            file_to_read = IOBuffer(response.body)
        else
            # Use the local file path
            file_to_read = data_file
        end

        # Open the dataset
        ds = Parquet2.Dataset(file_to_read)
        df = DataFrame(ds; copycols=false)  # Load the entire dataset initially

        # Apply column selection if provided
        if !isnothing(col_select)
            # Ensure column names are in the correct format
            col_select = [typeof(c) === Symbol ? string(c) : c for c in col_select]
            df = select(df, col_select)
        end

        # Apply skip and limit
        if skip > 0 || !isinf(n_max)
            start_idx = max(1, skip + 1)
            end_idx = !isinf(n_max) ? start_idx + n_max - 1 : nrow(df)
            df = df[start_idx:min(end_idx, nrow(df)), :]
        end

        # If column names should not be displayed as headers
        if !col_names
            # Create a DataFrame with the original column names as the first row
            col_names_df = DataFrame([transpose(names(df))], [:ColumnNames])
            # Concatenate the DataFrame with column names as the first row
            df = vcat(col_names_df, df)
            # Rename columns to generic names
            rename!(df, Symbol.(:Column, 1:ncol(df)))
        end

        # Concatenate the read DataFrame to the final DataFrame
        final_df = isempty(final_df) ? df : vcat(final_df, df, cols=:union)
    end

    return final_df
end

"""
$docstring_write_parquet
"""
function write_parquet(data, filename::String; buffer::Union{IO, Nothing}=nothing, 
    npages::Union{Int, Dict}=1, 
    compression_codec::Union{Symbol, Dict}=Dict(), 
    column_metadata::Union{Dict, Pair}=Dict(),
    metadata::Dict=Dict())
        # Choose the appropriate method to write data based on `buffer` presence
        if isnothing(buffer)
        # Write directly to file with options
        Parquet2.writefile(filename, data; npages=npages, compression_codec=compression_codec, 
        column_metadata=column_metadata, metadata=metadata)
    else
    # Write to the provided buffer
        Parquet2.writefile(buffer, data; npages=npages, compression_codec=compression_codec, 
        column_metadata=column_metadata, metadata=metadata)
    end
end