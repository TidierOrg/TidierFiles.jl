path = "/Users/danielrizk/Downloads/fwftest.txt"
read_fwf5(path, fwf_widths([12, 2, 17]))
read_fwf5(path, fwf_empty(path, num_lines= 4))
fwf_empty(path, num_lines= 4)
function fwf_widths(widths::Vector{Int})
    return widths
end

function fwf_positions(positions::Vector{Tuple{Int, Int}})
    widths = [end_pos - start_pos + 1 for (start_pos, end_pos) in positions]
    return widths
end

function read_fwf(filepath::String, widths::Vector{Int})
    # Open the file
    open(filepath, "r") do file
        # Read the first line to initialize the DataFrame with appropriate column types
        first_line = readline(file)
        seekstart(file)  # Reset file pointer to the start for the actual read process
        
        # Initialize columns based on widths
        columns = [String[] for _ in 1:length(widths)]
        column_names = [Symbol("Column_$i") for i in 1:length(widths)]
        
        # Process each line of the file
        for line in eachline(file)
            start_index = 1
            for (i, width) in enumerate(widths)
                end_index = min(start_index + width - 1, length(line))
                field = strip(line[start_index:end_index])  # Extract and strip the field
                push!(columns[i], field)  # Add the field to the appropriate column
                start_index = end_index + 1
            end
        end
        
        # Create a DataFrame from the columns
        df = DataFrame(columns, column_names)
        return df
    end
end

function fwf_empty(filepath::String; num_lines::Int=4)
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
        for i in 1:max_length
            if i > length(line)
                space_presence[i] += 1
            else
                char_presence[i] += (line[i] != ' ')
                space_presence[i] += (line[i] == ' ')
            end
        end
    end

    # Identify column boundaries based on transitions in character and space presence
    potential_boundaries = findall(x -> x > 0, diff(char_presence))
    widths = diff([0; potential_boundaries; max_length])

    # Adjust widths based on consistent space presence
    adjusted_widths = Int[]
    for i in 1:length(widths)
        if i == 1
            push!(adjusted_widths, widths[i])
        else
            # Check if there's a significant presence of spaces before the start of a new column
            if space_presence[potential_boundaries[i-1]] > num_lines * 0.75
                push!(adjusted_widths, widths[i])
            else
                # Adjust the previous width if the space presence is not significant
                adjusted_widths[end] += widths[i]
            end
        end
    end

    return adjusted_widths
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
