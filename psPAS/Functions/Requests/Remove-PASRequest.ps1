﻿function Remove-PASRequest {
	<#
.SYNOPSIS
Deletes a request from the Vault


.DESCRIPTION
Deletes a request from the Vault.
The "Manage" Safe vault permission is required.

.PARAMETER RequestID
The ID (composed of the Safe Name and internal RequestID.) of the request to delete.

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE
$token | Remove-PASRequest -RequestID "<ID>"

Deletes Request <ID>

.INPUTS
All parameters can be piped by property name

.OUTPUTS
None


.NOTES

.LINK

#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$RequestID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable]$sessionToken,

		[parameter(
			ValueFromPipelinebyPropertyName = $true
		)]
		[Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PVWAAppName = "PasswordVault"
	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/API/MyRequests/$($RequestID)"

		if($PSCmdlet.ShouldProcess($RequestID, "Delete Request")) {

			#Send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -Headers $sessionToken -WebSession $WebSession

		}

	}#process

	END {}#end
}