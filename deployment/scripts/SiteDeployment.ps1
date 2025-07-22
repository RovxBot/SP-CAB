# Add new site for deployment.
$SiteUrl = $env:DEPLOYMENT_SITE_URL
$SiteOwner = $env:DEPLOYMENT_SITE_OWNER

if (-not (Get-PnPTenantSite | Where-Object { $_.Url -eq $SiteUrl })) {
    New-PnPSite -Type CommunicationSite -Title "CAB Site" -Url "$SiteUrl" -Owner "$SiteOwner"
    Write-Host "Site created: $SiteUrl"
}
else {
    Write-Host "Site already exists: $SiteUrl"
}

# Site permissions using groups. Assign members to groups here as well.
$groups = @("CAB Admin", "CAB Approvers", "CAB Reviewers", "CAB Users")
foreach ($group in $groups) {
    if (-not (Get-PnPGroup | Where-Object { $_.Title -eq $group })) {
        New-PnPGroup -Title $group
        Write-Host "Group created: $group"
    } else {
        Write-Host "Group already exists: $group"
    }
    # Add users to group (replace with actual user login names)
    # Add-PnPUserToGroup -LoginName "user@domain.com" -Group $group
}

# Helper function to create or update a list field
function Makesure-PnPField  {
    param(
        [string]$List,
        [string]$DisplayName,
        [string]$InternalName,
        [string]$Type,
        [string[]]$Choices = $null
    )
    $field = Get-PnPField -List $List -Identity $InternalName -ErrorAction SilentlyContinue
    if (-not $field) {
        if ($Type -eq "Choice" -and $Choices) {
            Add-PnPField -List $List -DisplayName $DisplayName -InternalName $InternalName -Type $Type -Choices $Choices
        } else {
            Add-PnPField -List $List -DisplayName $DisplayName -InternalName $InternalName -Type $Type
        }
        Write-Host "Field created: $DisplayName ($InternalName) in $List"
    } else {
        Write-Host "Field already exists: $DisplayName ($InternalName) in $List"
        # Optionally update field settings here
    }
}

# Internal changes list
if (-not (Get-PnPList | Where-Object { $_.Title -eq "Internal Change Requests" })) {
    Add-PnPList -Title "Internal Change Requests" -Template GenericList
    Write-Host "List created: Internal Change Requests"
} else {
    Write-Host "List already exists: Internal Change Requests"
}
Makesure-PnPField  -List "Internal Change Requests" -DisplayName "Description" -InternalName "Description" -Type Text
Makesure-PnPField  -List "Internal Change Requests" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices @("New","Approved","Rejected","In Progress","Completed")
Makesure-PnPField  -List "Internal Change Requests" -DisplayName "Priority" -InternalName "Priority" -Type Choice -Choices @("Low","Medium","High","Critical")
Makesure-PnPField  -List "Internal Change Requests" -DisplayName "Requester" -InternalName "Requester" -Type Text
Makesure-PnPField  -List "Internal Change Requests" -DisplayName "Created Date" -InternalName "CreatedDate" -Type DateTime
Makesure-PnPField  -List "Internal Change Requests" -DisplayName "Modified Date" -InternalName "ModifiedDate" -Type DateTime

# Microsoft Changes List
if (-not (Get-PnPList | Where-Object { $_.Title -eq "Microsoft Changes" })) {
    Add-PnPList -Title "Microsoft Changes" -Template GenericList
    Write-Host "List created: Microsoft Changes"
} else {
    Write-Host "List already exists: Microsoft Changes"
}
Makesure-PnPField  -List "Microsoft Changes" -DisplayName "Description" -InternalName "Description" -Type Text
Makesure-PnPField  -List "Microsoft Changes" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices @("New","Approved","Rejected","In Progress","Completed")
Makesure-PnPField  -List "Microsoft Changes" -DisplayName "Priority" -InternalName "Priority" -Type Choice -Choices @("Low","Medium","High","Critical")
Makesure-PnPField  -List "Microsoft Changes" -DisplayName "Impact" -InternalName "Impact" -Type Text
Makesure-PnPField  -List "Microsoft Changes" -DisplayName "Category" -InternalName "Category" -Type Text
Makesure-PnPField  -List "Microsoft Changes" -DisplayName "Published Date" -InternalName "PublishedDate" -Type DateTime
Makesure-PnPField  -List "Microsoft Changes" -DisplayName "Ingested Date" -InternalName "IngestedDate" -Type DateTime
Makesure-PnPField  -List "Microsoft Changes" -DisplayName "User Priority" -InternalName "UserPriority" -Type Choice -Choices @("Low","Medium","High","Critical")
Makesure-PnPField  -List "Microsoft Changes" -DisplayName "Created Date" -InternalName "CreatedDate" -Type DateTime
Makesure-PnPField  -List "Microsoft Changes" -DisplayName "Modified Date" -InternalName "ModifiedDate" -Type DateTime



