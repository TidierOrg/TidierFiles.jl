module TestTidierFiles

using TidierFiles
using Test
using Documenter

DocMeta.setdocmeta!(TidierFiles, :DocTestSetup, :(begin
    using TidierFiles
    # Determine the package root directory dynamically
    project_root = dirname(dirname(pathof(TidierFiles)))
    testing_files_path = joinpath(project_root, "testing_files")
end); recursive=true)

doctest(TidierFiles)

end

