"""
$docstring_read_file
"""
function read_file(filepath::String, args...; kwargs...)
    ext = lowercase(splitext(filepath)[2])
    if ext == ".csv"
        return read_csv(filepath, args...; kwargs...)
    elseif ext == ".tsv"
        return read_tsv(filepath, args...; kwargs...)
    elseif ext == ".xlsx"
        return read_xlsx(filepath, args...; kwargs...)
    elseif ext == ".txt" || ext == ".dat"
        return read_delim(filepath, args...; kwargs...)
    elseif ext == ".fwf"
        return read_fwf(filepath, args...; kwargs...)
    elseif ext == ".sav" || ext == ".por"
        return read_sav(filepath, args...; kwargs...)
    elseif ext == ".sas7bdat" || ext == ".xpt"
        return read_sas(filepath, args...; kwargs...)
    elseif ext == ".dta"
        return read_dta(filepath, args...; kwargs...)
    elseif ext == ".arrow"
        return read_arrow(filepath, args...; kwargs...)
    elseif ext == ".parquet"
        return read_parquet(filepath, args...; kwargs...)
    elseif ext == ".rds" || ext == ".RData" || ext == ".rdata"
        return RData.load(filepath)
    else
        error("Unsupported file format: $ext")
    end
end


"""
$docstring_write_file
"""
function write_file(data::DataFrame,path::String, args...; kwargs...)
    ext = lowercase(splitext(path)[2])
    if ext == ".xlsx"
        sheet_name = get(kwargs, :sheet_name, "Sheet1")
        return write_xlsx((sheet_name => data,); path=path, overwrite=get(kwargs, :overwrite, false))
    elseif ext == ".csv"
        return write_csv(data, path, args...; kwargs...)
    elseif ext == ".tsv"
        return write_tsv(data, path, args...; kwargs...)
    elseif ext == ".txt" || ext == ".dat"
        return write_delim(data, path, args...; kwargs...)
    elseif ext == ".sav" || ext == ".por"
        return write_sav(data, path, args...; kwargs...)
    elseif ext == ".sas7bdat" || ext == ".xpt"
        return write_sas(data, path, args...; kwargs...)
    elseif ext == ".dta"
        return write_dta(data, path, args...; kwargs...)
    elseif ext == ".arrow"
        return write_arrow(data, path, args...; kwargs...)
    elseif ext == ".parquet"
        return write_parquet(data, path, args...; kwargs...)
    else
        error("Unsupported file format: $ext")
    end
end

function write_file(x::Tuple{Vararg{Pair{String, DataFrame}}}; path::String, overwrite::Bool=false)
    ext = lowercase(splitext(path)[2])
    if ext == ".xlsx"
        return write_xlsx(x; path=path, overwrite=overwrite)
    else
        error("Unsupported file format for multiple DataFrames: $ext")
    end
end
