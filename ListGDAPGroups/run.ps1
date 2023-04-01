using namespace System.Net

param($Request, $TriggerMetadata)

$Groups = $Request.body.gdapRoles

$Table = Get-CIPPTable -TableName GDAPMigrationGroups
$Rows = Get-AzDataTableEntity @Table

$RoleMappings = $Rows | ? roleDefinitionId -in $Groups.ObjectId

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
	StatusCode = [HttpStatusCode]::OK
	Body       = @($RoleMappings)
})