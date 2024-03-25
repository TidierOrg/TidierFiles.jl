xl_path = "/Users/danielrizk/Downloads/Assignment_Datasets/import.xlsx"
read_excel(xl_path)

df1 = DataFrames.DataFrame(COL1=[10,20,30], COL2=["First", "Second", "Third"])
df2 = DataFrames.DataFrame(AA=["sav", "por"], AB=[10.1, 10.2])


write_xlsx(("REPORT_A" => df1, "REPORT_B" => df2); path="/Users/danielrizk/Downloads/report.xlsx", overwrite = true)
read_excel("/Users/danielrizk/Downloads/report.xlsx", sheet = "REPORT_B", skip = 1, n_max = 4, missingstring = [10.2])
write_xlsx("REPORT_A" => df1; path="multi_sheet_report.xlsx")

XLSX.writetable("/Users/danielrizk/Downloads/report.xlsx", sheets)


XLSX.writetable("/Users/danielrizk/Downloads/report.xlsx", "REPORT_A" => df1, "REPORT_B" => df2)

csv_path ="/Users/danielrizk/Downloads/TidierDB.jl/mtcars.csv"
read_csv(csv_path)  


df = DataFrame(integers=[1, 2, 3, 4], strings=["This", "Package makes", "File reading/writing", "even smoother"], floats=[10.2, 20.3, 30.4, 40.5], dates=[Date(2018,2,20), Date(2018,2,21), Date(2018,2,22), Date(2018,2,23)], times=[Dates.Time(19,10), Dates.Time(19,20), Dates.Time(19,30), Dates.Time(19,40)], datetimes=[Dates.DateTime(2018,5,20,19,10), Dates.DateTime(2018,5,20,19,20), Dates.DateTime(2018,5,20,19,30), Dates.DateTime(2018,5,20,19,40)])
df1 = DataFrames.DataFrame(COL1=[10,20,30], COL2=["First", "Second", "Third"])

mtcarsastsv = read_csv(csv_path, col_names = true)
write_tsv(mtcarsastsv, "/Users/danielrizk/Downloads/mtcars.tsv"  )
read_tsv("/Users/danielrizk/Downloads/mtcars.tsv", num_threads = 5)
write_csv(mtcars, "/Users/danielrizk/Downloads/mtcars.csv")

read_csv("/Users/danielrizk/Downloads/mtcars.csv", col_names = true, num_threads = 5, missingstring = ["4"])
read_delim("/Users/danielrizk/Downloads/mtcars.tsv", delim = "\t")
read_delim("/Users/danielrizk/Downloads/mtcars.csv", delim = ",")

read_csv("/Users/danielrizk/Downloads/mtcars.tsv")
df = DataFrame(integers=[1, 2, 3, 4], strings=["This", "Package makes", "File reading/writing", "even smoother"], floats=[10.2, 20.3, 30.4, 40.5], dates=[Date(2018,2,20), Date(2018,2,21), Date(2018,2,22), Date(2018,2,23)], times=[Dates.Time(19,10), Dates.Time(19,20), Dates.Time(19,30), Dates.Time(19,40)], datetimes=[Dates.DateTime(2018,5,20,19,10), Dates.DateTime(2018,5,20,19,20), Dates.DateTime(2018,5,20,19,30), Dates.DateTime(2018,5,20,19,40)])
write_csv(df, "/Users/danielrizk/Downloads/testing.csv" , col_names= true, num_threads = 2)
read_csv("/Users/danielrizk/Downloads/testing.csv", missingstring=["40.5", "10.2"])

tsv_path = "/Users/danielrizk/Downloads/pythonsratch/UPDATED_NLP_COURSE/TextFiles/moviereviews.tsv"


read_excel("https://freetestdata.com/wp-content/uploads/2021/09/Free_Test_Data_100KB_XLSX.xlsx")
read_tsv("/Users/danielrizk/opt/anaconda3/pkgs/gensim-4.1.2-py39he9d5cce_0/lib/python3.9/site-packages/gensim/test/test_data/wordsim353.tsv")
read_tsv(tsv_path,col_names = false)


read_fwf("/Users/danielrizk/Downloads/fwftest.txt")
read_table("/Users/danielrizk/Downloads/fwftest.txt", col_names= false)

read_csv("https://github.com/tidyverse/readr/raw/main/inst/extdata/mtcars.csv", skip = 4, missingstring = ["1"])
read_tsv("https://github.com/tidyverse/readr/raw/main/inst/extdata/mtcars.csv", skip = 4, missingstring = ["1"])
read_delim("https://github.com/tidyverse/readr/raw/main/inst/extdata/mtcars.csv", skip = 4, missingstring = ["1"])

write_table(df, "/Users/danielrizk/Downloads/fwftest2.txt")
read_table( "/Users/danielrizk/Downloads/fwftest2.txt")


read_sas("/Users/danielrizk/Downloads/naws_all.sas7bdat", skip = 10, n_max=44 )

read_sav("/Users/danielrizk/Downloads/naws_all.sav", skip = 10, n_max=44)

read_dta("/Users/danielrizk/Downloads/naws_all.dta", skip = 15, n_max=44, num_threads = 10)

writestat("/Users/danielrizk/Downloads/test.dta", df)
using ReadStatTables
read_dta("https://www.dol.gov/sites/dolgov/files/ETA/naws/pdfs/NAWS_EPA.zip")

readstat
using HTTP
col_names = ["Name", "Age", "ID", "Position", "Salary"]
df2
widths_colnames = fwf_empty(path, num_lines=4, col_names = ["Name", "Age", "ID", "Position", "Salary"])
read_fwf(path, fwf_empty(path, num_lines=4, col_names = ["Name", "Age", "ID", "Position", "Salary"]), skip_to=3, n_max=3)

read_fwf("testing_files/fwftest.txt", fwf_empty("testing_files/fwftest.txt", num_lines= 4))
fwf_empty("testing_files/fwftest.txt")
df = DataFrames.DataFrame(AA=["sav", "por"], AB=[10.1, 10.2]);

write_sav(df2 , "/Users/danielrizk/Downloads/test2.sav")
write_sav(df2 , "/Users/danielrizk/Downloads/test2.por")


read_dta( "/Users/danielrizk/Downloads/test2.dta")