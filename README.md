# TidierFiles.jl

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/TidierOrg/Tidier.jl/blob/main/LICENSE)
[![Docs: Latest](https://img.shields.io/badge/Docs-Latest-blue.svg)](https://tidierorg.github.io/TidierFiles.jl/latest)

<img src="/assets/logo.png" align="right" style="padding-left:10px;" width="150"/>

## What is TidierFiles.jl?
TidierFiles.jl leverages the `CSV.jl`, `XLSX.jl`, and `ReadStatTables.jl` packages to reimplement the R `haven` and `readr` packages.

Currently supported file types 
- `read_csv` and `write_csv`
- `read_tsv` and `write_tsv`
- `read_xlsx` and `write_xlsx`
- `read_delim` and `write_delim`
- `read_table` and `write_table`
- `read_fwf` and `fwf_empty`
- `read_sav` and `write_sav` (.sav and .por)
- `read_sas` and `write_sas` (.sas7bdat and .xpt)
- `read_dta` and `write_dta` (.dta) 

# Examples
For CSVs (also TSV, white space tables, other delimters)
```
df = DataFrame(integers=[1, 2, 3, 4], strings=["This", "Package makes", "File reading/writing", "even smoother"], floats=[10.2, 20.3, 30.4, 40.5], dates=[Date(2018,2,20), Date(2018,2,21), Date(2018,2,22), Date(2018,2,23)], times=[Dates.Time(19,10), Dates.Time(19,20), Dates.Time(19,30), Dates.Time(19,40)])
write_csv(df, "/Users/danielrizk/Downloads/testing.csv" , col_names= true)
read_csv("/Users/danielrizk/Downloads/testing.csv", missingstring=["40.5", "10.2"])
```
```
4×5 DataFrame
 Row │ integers  strings               floats     dates       times    
     │ Int64     String31              Float64?   Date        Time     
─────┼─────────────────────────────────────────────────────────────────
   1 │        1  This                  missing    2018-02-20  19:10:00
   2 │        2  Package makes              20.3  2018-02-21  19:20:00
   3 │        3  File reading/writing       30.4  2018-02-22  19:30:00
   4 │        4  even smoother         missing    2018-02-23  19:40:00:00
```

For Excel files
```
df2 = DataFrames.DataFrame(AA=["aa", "bb"], AB=[10.1, 10.2])
write_xlsx(("REPORT_A" => df, "REPORT_B" => df2); path, overwrite = true)
read_excel(path, sheet = "REPORT_A", skip = 1, n_max = 4, missingstring = [20.3])
```
```
3×5 DataFrame
 Row │ integers  strings               floats   dates       times    
     │ Int64     String                Any      Date        Time     
─────┼───────────────────────────────────────────────────────────────
   1 │        2  Package makes         missing  2018-02-21  19:20:00
   2 │        3  File reading/writing  30.4     2018-02-22  19:30:00
   3 │        4  even smoother         40.5     2018-02-23  19:40:00

```
FOR FWF files
```
path = "fwftest.txt"
read_fwf(path, fwf_empty(path, num_lines=4, col_names = ["Name", "Age", "ID", "Position", "Salary"]), skip_to=3, n_max=6)
## `fwf_empty` will parse and guess path widths based on padding and user determined number of lines
```
```
6×5 DataFrame
 Row │ Name         Age     ID      Position             Salary   
     │ String       String  String  String               String   
─────┼────────────────────────────────────────────────────────────
   1 │ Bob Brown    31      12345   Product Manager      $110,000
   2 │ Charlie Day  28      34      Sales Associate      $70,000
   3 │ Diane Poe    35      23456   Data Scientist       $130,000
   4 │ Eve Stone    4       123456  Chief Financial Off  $200,000
   5 │ Frank Moore  33      1234    Graphic Designer     $80,000
   6 │ Grace Lee    27      123456  Software Developer   $115,000
```
