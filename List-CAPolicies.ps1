# Variables

$TenantID = "<TENANT-ID>"
$ClientID = "<CLIENT-ID"
$ClientSecret = "<CLIENT-SECRET>"

# Create a hashtable for the body, the data needed for the token request
# The variables used are explained above

$Body = @{
    'tenant' = $TenantId
    'client_id' = $ClientId
    'scope' = 'https://graph.microsoft.com/.default'
    'client_secret' = $ClientSecret
    'grant_type' = 'client_credentials'
}

# Assemble a hashtable for splatting parameters, for readability
# The tenant id is used in the uri of the request as well as the body

$Params = @{
    'Uri' = "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token"
    'Method' = 'Post'
    'Body' = $Body
    'ContentType' = 'application/x-www-form-urlencoded'
}

$AuthResponse = Invoke-RestMethod @Params

# Invoke request

$Headers = @{
    'Authorization' = "Bearer $($AuthResponse.access_token)"
}

$Result = Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies' `
    -Headers $Headers `
    -Method GET

$Result.value.id[0]