module TestTidierFiles

using TidierFiles
using Test
using Documenter

DocMeta.setdocmeta!(TidierFiles, :DocTestSetup, :(begin
    using DataFrames, TidierFiles
end); recursive=true)

doctest(TidierFiles)

end

