param(
    [string]$ClientId = $env:DEPLOYMENT_CLIENT_ID,
    [string]$TenantId = $env:DEPLOYMENT_TENANT_ID,
    [string]$CertificatePath = $env:DEPLOYMENT_CERTIFICATE,
    [string]$AppCatalogUrl = $env:SHAREPOINT_APP_CATALOG_URL,
    [string]$SiteUrl = $env:SHAREPOINT_SITE_URL
)

# Path to the .sppkg file
$sppkgPath = "$(Resolve-Path '../../src/spfx-solution/sharepoint/solution/*.sppkg').Path"

Write-Host "Authenticating to SharePoint App Catalog..."
Connect-PnPOnline -Url $AppCatalogUrl -ClientId $ClientId -Tenant $TenantId -CertificatePath $CertificatePath

Write-Host "Uploading $sppkgPath to App Catalog..."
Add-PnPApp -Path $sppkgPath -Publish -Overwrite

Write-Host "Deploying app to site $SiteUrl..."
Connect-PnPOnline -Url $SiteUrl -ClientId $ClientId -Tenant $TenantId -CertificatePath $CertificatePath
$app = Get-PnPApp | Where-Object { $_.Title -eq "SP-CAB" }
if ($app) {
    Install-PnPApp -Identity $app.Id -Scope Site -Overwrite
    Write-Host "App deployed successfully."
} else {
    Write-Host "App not found in App Catalog."
    exit 1
}
