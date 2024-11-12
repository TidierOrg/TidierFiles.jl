# TidierFiles.jl

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/TidierOrg/Tidier.jl/blob/main/LICENSE)
[![Docs: Latest](https://img.shields.io/badge/Docs-Latest-blue.svg)](https://tidierorg.github.io/TidierFiles.jl/latest)

<img src="docs/src/assets/logo.png" align="right" style="padding-left:10px;" width="150"/>

## What is TidierFiles.jl?

TidierFiles.jl is a 100% Julia implementation of the readr, haven, readxl, and writexl R packages.

Powered by the CSV.jl, XLSX.jl, ReadStatTables.jl, Arrow.jl, and Parquet2.jl packages, TidierFiles.jl aims to bring a consistent interface to the reading and writing of tabular data, including a consistent syntax to read files locally versus from the web and consistent keyword arguments across data formats.


Currently supported file types:
- `read_csv` and `write_csv`
- `read_tsv` and `write_tsv`
- `read_xlsx` and `write_xlsx`
- `read_delim` and `write_delim`
- `read_table` and `write_table`
- `read_fwf` and `fwf_empty`
- `read_sav` and `write_sav` (.sav and .por)
- `read_sas` and `write_sas` (.sas7bdat and .xpt)
- `read_dta` and `write_dta` (.dta) 
- `read_arrow` and `write_arrow`
- `read_parquet` and `write_parquet`
- `read_rdata` (.rdata and .rds)

Agnostic read and write functions that detect the type and dispatch the appropriate function. 
- `read_file` and `write_file` 

`list_files` to list files in a directory.

# Examples

Here is an example of how to write and read a CSV file.

```julia
using TidierFiles

df = DataFrame(
       integers = [1, 2, 3, 4],
       strings = ["This", "Package makes", "File reading/writing", "even smoother"],
       floats = [10.2, 20.3, 30.4, 40.5],
       dates = [Date(2018,2,20), Date(2018,2,21), Date(2018,2,22), Date(2018,2,23)],
       times = [Dates.Time(19,10), Dates.Time(19,20), Dates.Time(19,30), Dates.Time(19,40)]
     )

write_csv(df, "testing.csv" , col_names = true)

read_csv("testing.csv", missingstring=["40.5", "10.2"])
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

The file reading functions include the following keyword arguments:
- `path`
- `missing_value`
- `col_names`
- `col_select`
- `num_threads`
- `skip`
- `n_max`
- `delim` (where applicable)

The path can be a file available either locally or on the web.

```julia
read_csv("https://raw.githubusercontent.com/TidierOrg/TidierFiles.jl/main/testing_files/csvtest.csv", skip = 2, n_max = 3, col_select = ["ID", "Score"], missingstring = ["4"])
```
```
3×2 DataFrame
 Row │ ID       Score 
     │ Int64?   Int64 
─────┼────────────────
   1 │       3     77
   2 │ missing     85
   3 │       5     95
```

Read multiple files by passing paths as a vector. 
```
path = "https://raw.githubusercontent.com/TidierOrg/TidierFiles.jl/main/testing_files/csvtest.csv"
read_csv([path, path], skip=3)
```
```
4×3 DataFrame
 Row │ ID     Name     Score 
     │ Int64  String7  Int64 
─────┼───────────────────────
   1 │     4  David       85
   2 │     5  Eva         95
   3 │     4  David       85
   4 │     5  Eva         95
```