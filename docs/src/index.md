## What is TidierFiles.jl?

<img src="/assets/logo.png" align="right" style="padding-left:10px;" width="150"/>

TidierFiles.jl is a 100% Julia implementation of the readr and haven R packages.
Powered by the CSV.jl, XLSX.jl, ReadStatTables.jl, Arrow.jl and Parquet2.jl packages, TidierFiles.jl 
seeks to harmonize file reading/writing by unifying the arguments across multiple 
file types. 

TidierFiles.jl currently supports 
```@raw html
!!! example
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
```

Read functions include the following arguments and support HTTP reading:
- `path`
- `missingstring`
- `col_names`
- `col_select`
- `num_threads`
- `skip`
- `n_max`
- `delim` (where applies)

```julia
using TidierFiles

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