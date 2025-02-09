# The read_gsheet function allows you to read data from a Google Sheet into a DataFrame. This function supports various parameters to customize the data retrieval process. Below are the details of the parameters and examples of how to use the function.

# ## Secrets   
# At this time, to use `read_gsheet` the user will need to have a client ID and and client secret. 
# To get these, go to the Google Cloud Console -> APIs and Services -> Credentials (in sidebar) -> Create Credentials (at the top) -> OAuth Client ID (choose for desktop) -> save that client id and client secret.
# In the future, we hope to remove this need, so that authorization can happen more simply.

# ## Use
# client_id = "527478*******3dh26e.apps.googleusercontent.com"
# client_secret = "GO******j9yG"
# 
# connect_gsheet(client_id, client_secret)
# # The browser will ask you to allow access, after clicking allow, the browser will intruct you to close the browser window. The connection is stored globally for the functions to access.
# 
# spreadsheet_id = "1QbFtedQs56oIO1bjQKSwdpcWsMpo3r_04ZIrdg9_fFM"
# # Full google sheet links are also supported.
# df = read_gsheet(spreadsheet_id, col_names=true, n_max=5)
# # 4×4 DataFrame
# #  Row │ this       is       test     sheet
# #      │ Float64?   String?  String?  String?
# # ─────┼──────────────────────────────────────
# #    1 │       3.0  missing  missing  missing
# #    2 │ missing    columns  missing  missing
# #    3 │ missing    missing  are      missing
# #    4 │ missing    missing  missing  strings
# Reading from a Public Google Sheet at this time still requires authorization to be complete.
# 
# public_sheet = "https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit?gid=0#gid=0"
# read_gsheet(public_sheet, sheet="Class Data", col_names=true, n_max=5)
# # 5×6 DataFrame
# #  Row │ Student Name  Gender  Class Level   Home State  Major    Extracurricular Activity
# #      │ String        String  String        String      String   String
# # ─────┼───────────────────────────────────────────────────────────────────────────────────
# #    1 │ Alexandra     Female  4. Senior     CA          English  Drama Club
# #    2 │ Andrew        Male    1. Freshman   SD          Math     Lacrosse
# #    3 │ Anna          Female  1. Freshman   NC          English  Basketball
# #    4 │ Becky         Female  2. Sophomore  SD          Art      Baseball
# #    5 │ Benjamin      Male    4. Senior     WI          English  Basketball
# Notes
# Ensure that the Google Sheet is shared publicly or that the appropriate permissions are granted for the client_id and client_secret to access the sheet.
# The connect_gsheet function must be called first to obtain the auth object required for authentication.
# The function handles missing values and allows for customization of the data retrieval process through various parameters.
# This documentation provides a basic overview and examples of how to use the read_gsheet function. For more advanced usage, refer to the detailed parameter descriptions and customize the function calls as needed.