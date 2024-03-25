function fwf_widths(widths::Vector{Int}, col_names::Vector{String}=String[])
    return (widths, col_names)
end


function fwf_positions(positions::Vector{Tuple{Int, Int}}, col_names::Vector{String}=String[])
    widths = [end_pos - start_pos + 1 for (start_pos, end_pos) in positions]
    return (widths, col_names)
end

"""
$docstring_read_fwf
"""
function read_fwf(filepath::String, widths_colnames::Tuple{Vector{Int}, Union{Nothing, Vector{String}}}; skip_to=0, n_max=nothing)
    widths, col_names_provided = widths_colnames

    open(filepath, "r") do file
        # Skip the specified number of lines
        for _ in 1:skip_to
            readline(file)
        end
        
        # Generate or use provided column names
        if col_names_provided === nothing || isempty(col_names_provided)
            column_names = [Symbol("Column_$i") for i in 1:length(widths)]
            if col_names_provided !== nothing && isempty(col_names_provided)
                # Ensure column names are unique if col_names_provided is explicitly empty
                column_names = makeunique(column_names)
            end
        else
            column_names = Symbol.(col_names_provided)
        end
        
        # Initialize columns based on widths
        columns = [String[] for _ in 1:length(widths)]
        
        # Initialize a counter for the number of lines read
        lines_read = 0
        
        # Process each line of the file, respecting n_max if specified
        for line in eachline(file)
            # Check if we've reached the maximum number of lines to read
            if n_max !== nothing && lines_read >= n_max
                break
            end
            start_index = 1
            for (i, width) in enumerate(widths)
                end_index = min(start_index + width - 1, length(line))
                field = strip(line[start_index:end_index])  # Extract and strip the field
                push!(columns[i], field)  # Add the field to the appropriate column
                start_index = end_index + 1
            end
            lines_read += 1
        end
        
        # Create a DataFrame from the columns
        df = DataFrame(columns, column_names)
        return df
    end
end

"""
$docstring_fwf_empty
"""
function fwf_empty(filepath::String; num_lines::Int=4, col_names=nothing)
    # Read a sample of lines from the file
    lines = open(filepath, "r") do file
        [readline(file) for _ in 1:num_lines]
    end

    # Determine the maximum line length for consistent analysis
    max_length = maximum(length.(lines))
    char_presence = zeros(Int, max_length)
    space_presence = zeros(Int, max_length)

    # Analyze the character presence and space presence at each position
    for line in lines
        for i in 1:min(length(line), max_length)
            char_presence[i] += (line[i] != ' ')
            space_presence[i] += (line[i] == ' ')
        end
        # Increment space presence for trailing spaces in shorter lines
        for i in (length(line)+1):max_length
            space_presence[i] += 1
        end
    end

    # Identify column boundaries based on transitions in character and space presence
    potential_boundaries = findall(x -> x > 0, diff(char_presence))
    widths = diff([0; potential_boundaries; max_length])

    # Adjust widths based on consistent space presence
    adjusted_widths = Int[]
    for i in 1:length(widths)
        if i == 1 || space_presence[potential_boundaries[i-1]] > num_lines * 0.75
            push!(adjusted_widths, widths[i])
        else
            # Adjust the previous width if the space presence is not significant
            adjusted_widths[end] += widths[i]
        end
    end

    # Generate default column names if none were provided
    if col_names === nothing || isempty(col_names)
        col_names = ["Column_$i" for i in 1:length(adjusted_widths)]
    elseif length(col_names) != length(adjusted_widths)
        throw(ArgumentError("The number of column names does not match the number of detected columns."))
    end

    return adjusted_widths, col_names
end



function read_lines(filepath::String, num_lines::Int)
    lines = String[]
    open(filepath, "r") do file
        for _ in 1:num_lines
            eof(file) && break
            line = readline(file)
            push!(lines, line)
        end
    end
    return lines
end