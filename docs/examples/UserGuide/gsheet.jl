# The read_gsheet function allows you to read data from a Google Sheet into a DataFrame. This function supports various parameters to customize the data retrieval process. Below are the details of the parameters and examples of how to use the function.
# ## Arguemnts
# auth: Authentication object obtained from connect_gsheet function using client_id and client_secret.
# spreadsheet_id: The unique identifier of the Google Sheet.
# range (optional): The range of cells to read from the sheet (e.g., "A1:D10").
# col_names (optional): Boolean indicating whether the first row should be used as column names. Default is true.
# skip (optional): Number of rows to skip before starting to read data. Default is 0.
# n_max (optional): Maximum number of rows to read. Default is 1000.
# col_select (optional): List of column names or indices to select specific columns.
# missing_value (optional): Value to represent missing data.
# sheet (optional): Name of the sheet to read from if the spreadsheet contains multiple sheets.
# Examples
# Basic Usage
# client_id = "527478*******3dh26e.apps.googleusercontent.com"
# client_secret = "GO******j9yG"
# 
# auth = connect_gsheet(client_id, client_secret)
# # Allow then close the browser window
# 
# spreadsheet_id = "1QbFtedQs56oIO1bjQKSwdpcWsMpo3r_04ZIrdg9_fFM"
# 
# df = read_gsheet(auth, spreadsheet_id, col_names=true, n_max=5)
# # Output:
# # 4×4 DataFrame
# #  Row │ this       is       test     sheet
# #      │ Float64?   String?  String?  String?
# # ─────┼──────────────────────────────────────
# #    1 │       3.0  missing  missing  missing
# #    2 │ missing    columns  missing  missing
# #    3 │ missing    missing  are      missing
# #    4 │ missing    missing  missing  strings
# Reading from a Public Google Sheet
# 
# public_id = "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms"
# read_gsheet(auth, public_id, sheet="Class Data", col_names=true, n_max=5)
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