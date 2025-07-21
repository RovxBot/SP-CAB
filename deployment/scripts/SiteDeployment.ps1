# Add new site for deployment.
$SiteUrl = $env:DEPLOYMENT_SITE_URL
$SiteOwner = $env:DEPLOYMET_SITE_OWNER
New-PnPSite -Type CommunicationSite -Title "CAB Site" -Url "$SiteUrl" -Owner "$SiteOwner"


# Site permissions using groups. Assign members to groups here as well.
New-PnPGroup -Title "CAB Admin"
Add-PnPUserGroup -LoginName "{UserLoginName}" -Group "CAB Admin"
New-PnPGroup -Title "CAB Approvers"
Add-NewPnPUserGroup -LoginName "{UserLoginName}" -Group "CAB Approvers"
New-PnPGroup -Title "CAB Reviewers"
Add-PnPUserGroup -LoginaName "{UserLoginName}" -Group "CAB Reviewers"
New-PnPGroup -Title "CAB Users"
Add-PnPUserGroup -LoginName "{UserLoginName}" -Group "CAB Users"

# Create the SharePoint lists
# Internal changes list
Add-PnPList -Title "Internal Change Requests" -Templete GenericList
Add-PnPField -List "Internal Change Requests" -DisplayName "Title" -InternalName "Title" -Type Text
Add-PnPField -List "Internal Change Requests" -DisplayName "Description" -InternalName "Description" -Type Text
Add-PnPField -List "Internal Change Requests" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices "New","Approved","Rejected","In Progress","Completed"
Add-PnPField -List "Internal Change Requests" -DisplayName "Priority" -InternalName "Priority" -Type Choice -Choices "Low","Medium","High","Critical"
Add-PnPField -List "Internal Change Requests" -DisplayName "Requester" -InternalName "Requester" -Type Text
Add-PnPField -List "Internal Change Requests" -DisplayName "Created Date" -InternalName "CreatedDate" -Type DateTime
Add-PnPField -List "Internal Change Requests" -DisplayName "Modified Date" -InternalName "ModifiedDate" -Type DateTime

# Microsoft Changes List
Add-PnPList -Title "Microsoft Changes" -Template GenericList
Add-PnPField -List "Microsoft Changes" -DisplayName "Title" -InternalName "Title" -Type Text
Add-PnPField -List "Microsoft Changes" -DisplayName "Description" -Internal "Description" -Type Text
Add-PnPField -List "Microsoft Changes" -DisplayName "Status" -InternalName "Status" -Type Choice -Choices "New","Approved","Rejected","In Progress","Completed"
Add-PnPField -List "Microsoft Changes" -DisplayName "Priority" -InternalName "Priority" -Type Choice -Choices "Low","Medium","High","Critical"
Add-PnPField -List "Microsoft Changes" -DisplayName "Created Date" -InternalName "CreatedDate" -Type DateTime
Add-PnPField -List "Microsoft Changes" -DisplayName "Modified Date" -InternalName "ModifiedDate" -Type DateTime



