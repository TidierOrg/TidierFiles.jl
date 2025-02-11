
mutable struct GSheetAuth
    client_id::String
    client_secret::String
    redirect_uri::String
    access_token::String
end
global const GSHEET_AUTH = Ref{GSheetAuth}()
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
    You can now read Google Sheets from TidierFiles. Feel free to close this window.</body></html>
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
"""
$docstring_connect_gsheet
"""
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
    access_token = get_access_token(code, client_id, client_secret, redirect_uri)

    global GSHEET_AUTH[] = GSheetAuth(client_id, client_secret, redirect_uri, access_token)
    return GSHEET_AUTH[]
end

function parse_value(value::String, missing_value::String)
    if isempty(value)
        return missing
    elseif tryparse(Float64, value) !== nothing
        return parse(Float64, value)
    else
        return value
    end
end

"""
$docstring_read_gsheet
"""
function read_gsheet(spreadsheet_id::String;
                     sheet::String="Sheet1", 
                     range::String="", 
                     col_names::Bool=true, 
                     skip::Int=0, 
                     n_max::Int=10000, 
                     col_select=nothing, 
                     missing_value::String="")

    # If a full Google Sheets URL is provided, extract the spreadsheet id.
    if occursin("spreadsheets/d/", spreadsheet_id)
        m = match(r"spreadsheets/d/([^/]+)", spreadsheet_id)
        if m !== nothing
            spreadsheet_id = m.captures[1]
        end
    end
  
    isempty(range) ?  range = "A1:Z1000" : range
    range = sheet * "!" * range
  
    url = "https://sheets.googleapis.com/v4/spreadsheets/$spreadsheet_id/values/$(HTTP.escapeuri(range))"
    headers = ["Authorization" => "Bearer $(GSHEET_AUTH[].access_token)"]
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
  
    rows = rows[skip+1:min(skip+n_max, end)]
  
    max_length = maximum(length(row) for row in rows)
  
    padded_rows = [vcat(row, fill(missing_value, max_length - length(row))) for row in rows]
  
    parsed_rows = [[parse_value(cell, missing_value) for cell in row] for row in padded_rows]
  
    df = DataFrame([Symbol(header[i]) => [row[i] for row in parsed_rows] for i in 1:length(header)])
  
    for i in (length(header)+1):max_length
        df[!, Symbol("x$(i-length(header))")] = [row[i] for row in parsed_rows]
    end
  
    if col_select !== nothing
        df = df[:, col_select]
    end
  
    if missing_value != ""
        for col in names(df)
            df[!, col] = coalesce.(df[!, col], missing_value)
        end
    end
  
    return df
  end
  
"""
$docstring_write_gsheet
"""
function write_gsheet(data::DataFrame, spreadsheet_id::String; sheet::String="Sheet1", range::String="", missing_value::String = "", append::Bool = false)
    # URL-escape spreadsheet_id if necessary by extracting it from a full URL.
    if occursin("spreadsheets/d/", spreadsheet_id)
        m = match(r"spreadsheets/d/([^/]+)", spreadsheet_id)
        if m !== nothing
            spreadsheet_id = m.captures[1]
        end
    end

    # Use a default range if none is provided.
    if isempty(range)
        range = "A1"
    end

    # If appending, use only the sheet name; if not, use "sheet!range".
    loc = append ? sheet : sheet * "!" * range
    loc = HTTP.escapeuri(loc)

    headers = ["Authorization" => "Bearer  $(GSHEET_AUTH[].access_token)", "Content-Type" => "application/json"]

    # Convert the DataFrame to a JSON object replacing missing values.
    col_names = [string(c) for c in names(data)]
    rows_data = [map(x -> ismissing(x) ? missing_value : x, collect(row)) for row in eachrow(data)]
    # If appending, do not include the header; otherwise, prepend the header.
    rows = append ? rows_data : vcat([col_names], rows_data)
    body = Dict("values" => rows)

    if append
        # For appending data, use the append endpoint with POST.
        url = "https://sheets.googleapis.com/v4/spreadsheets/$spreadsheet_id/values/$loc:append?valueInputOption=USER_ENTERED&insertDataOption=INSERT_ROWS"
        response = HTTP.post(url, headers, JSON3.write(body))
    else
        # For updating (overwriting) data, use the update endpoint with PUT.
        url = "https://sheets.googleapis.com/v4/spreadsheets/$spreadsheet_id/values/$loc?valueInputOption=USER_ENTERED"
        response = HTTP.put(url, headers, JSON3.write(body))
    end

    if response.status != 200
        error("Failed to write to Google Sheets: $(String(response.body))")
    end

    # If not appending, clear out any cells below the new data.
    if !append
        # Determine how many rows were written (including header).
        new_N = length(rows)
        # Helper function: convert a 1-indexed column number to its corresponding letter.
        function col_letter(n::Int)
            s = ""
            while n > 0
                rem = (n - 1) % 26
                s = Char(rem + 'A') * s
                n = (n - 1) ÷ 26
            end
            return s
        end
        last_col = col_letter(length(col_names))
        # Build a clear range from the row after new data to a high row (here, row 1000).
        clear_range = "$(sheet)!A$(new_N+1):$(last_col)1000"  # note the parentheses around sheet
        clear_range = HTTP.escapeuri(clear_range)
        clear_url = "https://sheets.googleapis.com/v4/spreadsheets/$spreadsheet_id/values/$clear_range:clear"
        clear_response = HTTP.post(clear_url, headers, "{}")
        if clear_response.status != 200
            error("Failed to clear remaining cells: $(String(clear_response.body))")
        end
    end

    return response
end
