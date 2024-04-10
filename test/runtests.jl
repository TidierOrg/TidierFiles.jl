module TestTidierFiles

using TidierFiles
using Test
using Documenter

DocMeta.setdocmeta!(TidierFiles, :DocTestSetup, :(begin
    using TidierFiles
    # Determine the package root directory dynamically
    # project_root = dirname(dirname(pathof(TidierFiles)))
    testing_files_path = tempdir()

    # Need to write fwf data because there is no `write_fwf()` function
    # For every other file, write_* is written before read_* to ensure that
    # the read_* function can read the output of the corresponding
    # write_* function
    
    fwf_data = """
    John Smith   35    12345  Software Engineer   120,000 
    Jane Doe     29     2345  Marketing Manager   95,000  
    Alice Jones  42   123456  CEO                 250,000 
    Bob Brown    31    12345  Product Manager     110,000 
    Charlie Day  28      345  Sales Associate     70,000  
    Diane Poe    35    23456  Data Scientist      130,000 
    Eve Stone    40   123456  Chief Financial Off 200,000 
    Frank Moore  33     1234  Graphic Designer    80,000  
    Grace Lee    27   123456  Software Developer  115,000 
    Hank Zuse    45    12345  System Analyst      120,000 
    """
    
    file = open(joinpath(testing_files_path, "fwftest.txt"), "w")
    write(file, fwf_data)
    close(file)
    
end); recursive=true)

doctest(TidierFiles)

end

