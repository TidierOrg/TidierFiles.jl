function specialConvert(col)
    return ismissing(col) ? missing : Float64(col)
end

function fixTypes(df::DataFrame)::DataFrame
    for (name, col) in pairs(eachcol(df))

        elemtype = eltype(col)
      
        if typeof(elemtype) == Union
            ut = Base.uniontypes(elemtype)
            if Int64 in ut && Float64 in ut

                df[!,name] = specialConvert.(col)

            end
        end
        
    end

    return df
end


function checkIfVectorFormat(parsedJSON)
 
    len = 0

    for (key, value) in pairs(parsedJSON)
        typeof(value) != Vector{Any} && return false
       
        thisLen = length(value)
        len > 0 && thisLen != len && return false
        len = thisLen

    end
    return true
end

function fixTypesVectorFormat(df::DataFrame)
    for (name, col) in pairs(eachcol(df))
      try
            t = typeof(col[1])
          
            df[!,name] = convert(Vector{t}, col)
       catch
          return df
      end
        
    end
    return df
end

"""
$docstring_read_json
"""
function read_json(path::String; null = missing, convertMixedNumberTypes::Bool = true) 
   
    parsedJSON = nothing
    df = nothing
   
    if occursin("http", path) 
        response = HTTP.get(path)
         # Ensure the request was successful
         if response.status != 200
            error("Failed to fetch the JSON file: HTTP status code ", response.status)
        end
        file_to_read = IOBuffer(response.body)
        parsedJSON = JSON.parse(file_to_read; null=null)   
         
    else
    
        open(path, "r") do io
            parsedJSON = JSON.parse(io;null=null)
        end
        
    end

    if checkIfVectorFormat(parsedJSON)
        df = DataFrame([v for v in values(parsedJSON)],[k for k in keys(parsedJSON) ] )  
        return fixTypesVectorFormat(df)
       
    else
        df = DataFrame(Tables.dictrowtable(parsedJSON))
        return (convertMixedNumberTypes) ? fixTypes(df) : df
    end

end

"""
$docstring_write_json
"""
function write_json(df::DataFrame, path::String;JSONObjectVector::Bool=true)
    if JSONObjectVector
        columnNames = names(df)
      
        dicts = [ Dict{ String, Any }((columnNames .=> values(row))) for row in eachrow(df) ]

        json_string = JSON.json(dicts)
    else 
        json_string = JSON.json(df)
    end
        open(path, "w") do io
            write(io, json_string)
        end
end
