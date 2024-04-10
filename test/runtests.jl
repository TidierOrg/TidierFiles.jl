module TestTidierFiles

using TidierFiles
using Test
using Documenter

DocMeta.setdocmeta!(TidierFiles, :DocTestSetup, :(begin
    using DataFrames, TidierFiles
    # Determine the package root directory dynamically
    # project_root = dirname(dirname(pathof(TidierFiles)))
    testing_files_path = tempdir()

    # Need to write fwf data because there is no `write_fwf()` function
    # Because each doctest runs independently, need to write all the files
    # here to ensure they are available to the read_ functions.
    
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

    df = DataFrame(ID = 1:5, Name = ["Alice", "Bob", "Charlie", "David", "Eva"], Score = [88, 92, 77, 85, 95]);
    write_csv(df, joinpath(testing_files_path, "csvtest.csv"));
    write_table(df, joinpath(testing_files_path, "tabletest.txt"));
    write_tsv(df, joinpath(testing_files_path, "tsvtest.tsv"));

    df = DataFrame(integers=[1, 2, 3, 4],
       strings=["This", "Package makes", "File reading/writing", "even smoother"],
       floats=[10.2, 20.3, 30.4, 40.5]);
    df2 = DataFrame(AA=["aa", "bb"], AB=[10.1, 10.2]);
    write_xlsx(("REPORT_A" => df, "REPORT_B" => df2); path=joinpath(testing_files_path, "xlsxtest.xlsx"), overwrite = true);

    df = DataFrame(AA=["sav", "por"], AB=[10.1, 10.2]);
    write_sav(df, joinpath(testing_files_path, "test.sav"));
    write_sav(df, joinpath(testing_files_path, "test.por"));
    write_sas(df , joinpath(testing_files_path, "test.sas7bdat"));
    write_sas(df , joinpath(testing_files_path, "test.xpt"));
    write_dta(df , joinpath(testing_files_path, "test.dta"));
    
end); recursive=true)

doctest(TidierFiles)

end

