<#
.SYNOPSIS
    PowerShell script to export Power Platform Data Loss Prevention (DLP) policies with environment and custom connector details.

.DESCRIPTION
    This script connects to Power Platform using admin cmdlets, retrieves all DLP policies, maps environments to display names, 
    identifies blocked custom connectors, and exports the data to a CSV file.

.AUTHOR
    [Your Name] (GitHub: @vasavisuggala)

.VERSION
    1.0.0

.REQUIREMENTS
    - Microsoft.PowerApps.Administration.PowerShell
    - Microsoft.PowerApps.PowerShell

.LICENSE
    MIT License
#>

# Connect to Power Platform
Add-PowerAppsAccount

# Retrieve all DLP policies
$dlpPolicies = @(Get-DlpPolicy | ForEach-Object { $_.PSObject.Properties.Value })

# Retrieve all environments
$allEnvironments = @(Get-AdminPowerAppEnvironment | Select-Object EnvironmentName, DisplayName)

# Retrieve all custom connectors
$customConnectors = Get-AdminCustomConnector | Select-Object Name, ConnectorId, EnvironmentName, Properties

# Process and format DLP policies
$dlpPoliciesFormatted = $dlpPolicies | ForEach-Object {
    $policy = $_

    # Categorize connectors
    $businessConnectors = ($policy.ConnectorGroups | Where-Object { $_.classification -eq "Confidential" } |
        ForEach-Object { $_.connectors | Select-Object -ExpandProperty name }) -join "; "

    $nonBusinessConnectors = ($policy.ConnectorGroups | Where-Object { $_.classification -eq "General" } |
        ForEach-Object { $_.connectors | Select-Object -ExpandProperty name }) -join "; "

    $blockedConnectors = ($policy.ConnectorGroups | Where-Object { $_.classification -eq "Blocked" } |
        ForEach-Object { $_.connectors | Select-Object -ExpandProperty name }) -join "; "

    # Extract environment GUIDs and display names
    $environmentIDs = ($policy.Environments.id | ForEach-Object { $_ -replace ".*/environments/", "" }) -join "; "
    $envDisplayNames = ($environmentIDs -split "; " | ForEach-Object {
        $env = $allEnvironments | Where-Object { $_.EnvironmentName -eq $_ }
        if ($env) { $env.DisplayName } else { "Unknown" }
    }) -join "; "

    # Get blocked custom connectors
    $blockedCustomConnectorIds = $policy.ConnectorGroups |
        Where-Object { $_.classification -eq "Blocked" } |
        ForEach-Object { $_.connectors | Where-Object { $_.id -match "^[^_]+$" } | Select-Object -ExpandProperty id }

    # Find matching custom connectors
    $blockedCustomConnectorDetails = $blockedCustomConnectorIds | ForEach-Object {
        $custom = $customConnectors | Where-Object { $_.ConnectorId -eq $_ }
        if ($custom) {
            "$($custom.Name) (`$($custom.Properties.apiDefinitionUrl))"
        }
    } -join "; "

    # Output object
    [PSCustomObject]@{
        PolicyName                  = $policy.name
        DisplayName                 = $policy.DisplayName
        DefaultClassification       = $policy.DefaultConnectorsClassification
        BusinessConnectors          = $businessConnectors
        NonBusinessConnectors       = $nonBusinessConnectors
        BlockedConnectors           = $blockedConnectors
        BlockedCustomConnectors     = $blockedCustomConnectorDetails
        EnvironmentType             = $policy.EnvironmentType
        Environments                = $environmentIDs
        EnvironmentDisplayNames     = $envDisplayNames
        CreatedBy                   = $policy.CreatedBy.displayName
        CreatedTime                 = $policy.CreatedTime
        LastModifiedBy              = $policy.LastModifiedBy.displayName
        LastModifiedTime            = $policy.LastModifiedTime
        IsLegacySchemaVersion       = $policy.isLegacySchemaVersion
    }
}

# Export to CSV
$csvPath = "C:\Users\Public\Documents\Dlp_With_Custom.csv"
$dlpPoliciesFormatted | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8 -Force

Write-Host "✅ DLP Policies with custom connectors exported to $csvPath"
