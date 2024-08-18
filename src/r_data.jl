"""
$docstring_read_rdata
"""
function read_rdata(file::String)
    return RData.load(file)
end