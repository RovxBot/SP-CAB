#certificate built from SP_CERT_PEM and stored temporarily
$certPath = "./deployment/scripts/CABDeployment.pfx"

# Connect to graph API
$token = Get-GraphToken -ClientID $env:INGESTION_CLIENT_ID -TenantId $env:DEPLOYMENT_TENANT_ID -ClientSecret $env:INGESTION_CLIENT_SECRET

# Collect updates from the message centre
$updates = Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/admin/serviceAnnouncement/messages" -Headers @{Authorization = "Bearer $token"}

# Connect to SharePoint with PnP PowerShell
Connect-PnPOnline -Url $env:DEPLOYMENT_SITE_URL -ClientId $env:INGESTION_CLIENT_ID -Tenant $env:DEPLOYMENT_TENANT_ID -CertificatePath $certPath -CertificatePassword ""

# Push updates to the Microsoft Changes List
foreach ($update in $updates.value) {
    Add-PnPListItem - List "Microsoft Changes" -Values @{
        Title = $update.Title
        Description = $update.body.content
        Category = $update.category
        Status = $update.status
        PublishedDate = $update.publishedDateTime
        IngestDate = (Get-Date)
    }
}