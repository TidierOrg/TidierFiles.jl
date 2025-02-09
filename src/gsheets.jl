
using JSON3
using Random
using Sockets
using HTTP

# Struct to store authentication information
mutable struct GSheetAuth
    client_id::String
    client_secret::String
    redirect_uri::String
    access_token::String
end

# Helper function to open a URL in the default browser
function open_browser(url::String)
    if Sys.iswindows()
        run(`start $url`)
    elseif Sys.isapple()
        run(`open $url`)
    elseif Sys.islinux()
        run(`xdg-open $url`)
    else
      #  println("Please open the following URL in your browser:")
     #   println(url)
    end
end

# Start a simple loopback server to capture the code
function get_authorization_code(port::Int, auth_url::String)
    open_browser(auth_url)
    println("Waiting for redirect on http://localhost:$port ...")

    server = Sockets.listen(port)
    sock = Sockets.accept(server)
    request = String(readavailable(sock))

    # Print the entire request for debugging
    println("Received request:")
    println(request)

    # Look for the 'code' parameter in the GET request
    m = match(r"code=([^&\s]+)", request)
    if m === nothing
        error("Authorization code not found in the request")
    end
    code = String(m.captures[1])  # Convert to String

    # Print the captured code for debugging
   # println("Captured code: $code")

    # Send a simple HTTP response
    response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    \r
    <html><body><h1>Authorization complete</h1>
    You can close this window.</body></html>
    """
    write(sock, response)
    close(sock)
    close(server)
    return code
end

# Exchange the authorization code for an access token
function get_access_token(code::String, client_id::String, client_secret::String, redirect_uri::String)
    token_url = "https://oauth2.googleapis.com/token"
    response = HTTP.post(token_url, ["Content-Type" => "application/x-www-form-urlencoded"],
                         "code=$code&client_id=$client_id&client_secret=$client_secret&redirect_uri=$redirect_uri&grant_type=authorization_code")
    if response.status != 200
        error("Failed to get access token: $(String(response.body))")
    end
    token_data = JSON3.read(String(response.body))
    return token_data["access_token"]
end

# Function to connect to Google Sheets and get the access token
function connect_gsheet(client_id::String, client_secret::String; redirect_uri::String = "http://localhost:8081")
    scope = "https://www.googleapis.com/auth/spreadsheets"
    state = "random_state_string"  # ideally, generate a random string
    auth_url = "https://accounts.google.com/o/oauth2/v2/auth?" *
               "client_id=$client_id&" *
               "redirect_uri=$(HTTP.escapeuri(redirect_uri))&" *
               "response_type=code&" *
               "scope=$(HTTP.escapeuri(scope))&" *
               "state=$state"

    code = get_authorization_code(8081, auth_url)
   # println("Authorization code: $code")
    
    access_token = get_access_token(code, client_id, client_secret, redirect_uri)
   # println("Access token: $access_token")

    return GSheetAuth(client_id, client_secret, redirect_uri, access_token)
end
function read_gsheet(auth::GSheetAuth, spreadsheet_id::String; sheet::String="Sheet1", range::String="", col_names::Bool=true, skip::Int=0, n_max::Int=Inf, col_select=nothing, missing_value::String="")

  isempty(range) ?  range = "A1:Z1000" : range
  range = sheet * "!" * range

  url = "https://sheets.googleapis.com/v4/spreadsheets/$spreadsheet_id/values/$(HTTP.escapeuri(range))"
  headers = ["Authorization" => "Bearer $(auth.access_token)"]
  response = HTTP.get(url, headers)
  data = JSON3.read(String(response.body))

  values = data["values"]

  if isempty(values)
      return DataFrame()
  end

  if col_names
      header = values[1]
      rows = values[2:end]
  else
      header = ["Column$i" for i in 1:length(values[1])]
      rows = values
  end

  # Skip rows
  rows = rows[skip+1:min(skip+n_max, end)]

  # Find the maximum length of the rows
  max_length = maximum(length(row) for row in rows)

  # Pad the rows to have the same length
  padded_rows = [vcat(row, fill(missing_value, max_length - length(row))) for row in rows]

  # Convert empty strings to missing and numeric strings to numbers
  function parse_value(value::String, missing_value::String)
      if isempty(value)
          return missing
      elseif tryparse(Float64, value) !== nothing
          return parse(Float64, value)
      else
          return value
      end
  end

  parsed_rows = [[parse_value(cell, missing_value) for cell in row] for row in padded_rows]

  # Create a DataFrame
  df = DataFrame([Symbol(header[i]) => [row[i] for row in parsed_rows] for i in 1:length(header)])

  # Add additional columns for extra values
  for i in (length(header)+1):max_length
      df[!, Symbol("x$(i-length(header))")] = [row[i] for row in parsed_rows]
  end

  # Select columns if col_select is provided
  if col_select !== nothing
      df = df[:, col_select]
  end

  # Replace missing values with the specified missing_value
  if missing_value != ""
      for col in names(df)
          df[!, col] = coalesce.(df[!, col], missing_value)
      end
  end

  return df
end