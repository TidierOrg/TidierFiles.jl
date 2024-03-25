module TestTidierFiles

using TidierFiles
using Test
using Documenter

DocMeta.setdocmeta!(TidierFiles, :DocTestSetup, :(using TidierFiles); recursive=true)

doctest(TidierFiles)

end

