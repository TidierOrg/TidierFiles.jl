# The `read_gsheet` function allows enables TidierFiles to read Google Sheets in as DataFrames. 
# `read_gsheet` supports various arguements in line with other TidierFiles readers. 

# ## Secrets   
# At this time, to use `read_gsheet` the user will need to have a client ID and and client secret. 
# To get these, go to the Google Cloud Console -> APIs and Services -> Credentials (in sidebar) -> Create Credentials (at the top) -> OAuth Client ID (choose for desktop) -> save that client id and client secret.
# In the future, we hope to remove this need, so that authorization can happen more simply.

# ## Authorization
# The browser will ask you to allow access, after clicking allow, the browser will intruct you to close the browser window. The connection is stored globally for the functions to access.
# ```
# client_id = "527478*******3dh26e.apps.googleusercontent.com"
# client_secret = "GO******j9yG"
# connect_gsheet(client_id, client_secret)
# ```
# ## Reading
# File paths can either be be full links, or spreadsheet ids
# The sheet name defaults to `Sheet1` but can be changed as shown below.
# ```
# spreadsheet_id = "1QbFtedQs56oIO1bjQKSwdpcWsMpo3r_04ZIrdg9_fFM"
# read_file(spreadsheet_id)
# 4×4 DataFrame
#  Row │ this       is       test     sheet   
#      │ Float64?   String?  String?  String? 
# ─────┼──────────────────────────────────────
#    1 │       3.0  missing  missing  missing 
#    2 │ missing    COLUMNS  missing  missing 
#    3 │ missing    missing  ARE      missing 
#    4 │ missing    missing  missing  STRINGS
# ```
# 
# ## Read a particular sheet
# ```
# public_sheet = "https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit?gid=0#gid=0"
# read_gsheet(public_sheet, sheet="Class Data", col_names=true, n_max=5)
# 5×6 DataFrame
#  Row │ Student Name  Gender  Class Level   Home State  Major    Extracurricular Activity 
#      │ String        String  String        String      String   String                   
# ─────┼───────────────────────────────────────────────────────────────────────────────────
#    1 │ Alexandra     Female  4. Senior     CA          English  Drama Club
#    2 │ Andrew        Male    1. Freshman   SD          Math     Lacrosse
#    3 │ Anna          Female  1. Freshman   NC          English  Basketball
#    4 │ Becky         Female  2. Sophomore  SD          Art      Baseball
#    5 │ Benjamin      Male    4. Senior     WI          English  Basketball
# ```
# 