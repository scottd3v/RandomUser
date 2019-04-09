<#
delete this line
References:
    -Building a PowerShell Module: https://ramblingcookiemonster.github.io/Building-A-PowerShell-Module/
    -Decorating PowerShell Objects (.ps1xml): https://ramblingcookiemonster.github.io/Decorating-Objects/
    -Run Git commands in a script: https://docs.microsoft.com/en-us/azure/devops/pipelines/scripts/git-commands?view=azure-devops&tabs=yaml
    -How to Write a PowerShell Module Manifest: https://docs.microsoft.com/en-us/powershell/developer/module/how-to-write-a-powershell-module-manifest
    -BuildHelpers Invoke-Git.ps1: https://github.com/RamblingCookieMonster/BuildHelpers/blob/master/BuildHelpers/Public/Invoke-Git.ps1
#>
# Set variables from Azure Pipelines
# $ModuleName = $env:moduleName
# $ModuleFolderName = $env:moduleFolderName
# $JCAPIKEY = $env:xApiKey
# $SingleAdminAPIKey = $env:xApiKey
# $NuGetApiKey = $env:nuGetApiKey
# $GitSourceBranch = $env:BUILD_SOURCEBRANCHNAME
# $ScriptRoot = Switch ($env:deployFolder) { $true { $env:deployFolder } Default { $PSScriptRoot } }
# $Folder_ModuleRootPath = (Get-Item -Path:($ScriptRoot)).Parent.FullName
# $ReleaseType = $env:ReleaseType

# For testing locally

$ModuleName = 'RandomUser'

$ModuleFolderName = 'RandomUser'

#$JCAPIKEY = ''
#
#$SingleAdminAPIKey = ''
#
#$NuGetApiKey = ''

$GitSourceBranch = 'ci'

$ReleaseType = 'Major'

$ScriptRoot = $PSScriptRoot

. ($ScriptRoot + '\Build-HelpFiles.ps1')

. ($ScriptRoot + '\Build-PesterTestFiles.ps1')

. ($ScriptRoot + '\Build-Module.ps1')

# . ($ScriptRoot + '\Execute-GitCommit.ps1')

. ($ScriptRoot + '\Run-ValidateHelpFiles.ps1')

. ($ScriptRoot + '\Run-ValidatePesterTestFiles.ps1')

# Define OS specific variables
$WindowsDeliminator = '\'
$UnixDeliminator = '/'
$PathDeliminator = Switch ([environment]::OSVersion.Platform) { 'Win32NT' { $WindowsDeliminator }'Unix' { $UnixDeliminator } }
Write-Host ('[status]Running on OS: ' + [environment]::OSVersion.Platform)
# Define folder path variables
$Folder_Module = $Folder_ModuleRootPath + $PathDeliminator + $ModuleFolderName
$Folder_Private = $Folder_Module + $PathDeliminator + 'Private'
$Folder_Public = $Folder_Module + $PathDeliminator + 'Public'
$Folder_HelpFiles = $Folder_Module + $PathDeliminator + 'en-US'
$Folder_Tests = $Folder_Module + $PathDeliminator + 'Tests'
$Folder_Docs = $Folder_Module + $PathDeliminator + 'Docs'
# Define file path variables
$File_Psm1 = $Folder_Module + $PathDeliminator + $ModuleName + '.psm1'
$File_Psd1 = $Folder_Module + $PathDeliminator + $ModuleName + '.psd1'
# Define list variables
$RequiredFolders = ('Docs', 'Private', 'Public', 'Tests')
$RequiredFiles = ('LICENSE', ($ModuleName + '.psm1'), ($ModuleName + '.psd1'))
# Get module function names
$Functions_Public = If (Test-Path -Path:($Folder_Public)) { Get-ChildItem -Path:($Folder_Public + $PathDeliminator + '*.ps1') -Recurse }
$Functions_Private = If (Test-Path -Path:($Folder_Private)) { Get-ChildItem -Path:($Folder_Private + $PathDeliminator + '*.ps1') -Recurse }
# Load deploy functions
$DeployFunctions = @(Get-ChildItem -Path:($PSScriptRoot + '\Functions\*.ps1') -Recurse)
Foreach ($DeployFunction In $DeployFunctions)
{
    Try
    {
        . $DeployFunction.FullName
    }
    Catch
    {
        Write-Error -Message:("Failed to import function $($DeployFunction.FullName): $_")
    }
}
###########################################################################
# KEEP                    | Docs
# KEEP                    | Private
# KEEP                    | Public
# KEEP (RENAME Tests)     | test
# KEEP                    | LICENSE
# KEEP                    | JumpCloud.psm1
# UPDATE FROM SCRIPT VARS | JumpCloud.psd1
# REMOVE                  | ModuleUpdate.ps1
# REMOVE                  | en-Us
# ADD (TBD)               | Template.Format.ps1xml


If (!(Get-PackageProvider -Name:('NuGet') -ListAvailable -ErrorAction:('SilentlyContinue'))) { Write-Host ('[status]Installing package provider NuGet'); Install-PackageProvider -Name:('NuGet') -Scope:('CurrentUser') -Force }
# Switch ([environment]::OSVersion.Platform)
# {
#     'Win32NT'
#     {
#         $ScoopPath = 'C:\Temp\Scoop'
#         $ScoopFile = $ScoopPath + '\shims\scoop.cmd'
#         # If (!(Test-Path -Path:($ScoopPath)))
#         # {
#             [environment]::setEnvironmentVariable('SCOOP', $ScoopPath, 'User')
#             $env:SCOOP = $ScoopPath
#             # Set-ExecutionPolicy -ExecutionPolicy:('RemoteSigned') -Scope:('CurrentUser')
#             Invoke-Expression ((New-Object Net.WebClient).DownloadString('https://get.scoop.sh'))
#             Invoke-Expression ($ScoopFile + ' install git')
#             Invoke-Expression ($ScoopFile + ' install openssh')
#             [environment]::SetEnvironmentVariable('GIT_SSH', (Resolve-Path (scoop which ssh)), 'USER')
#             Invoke-Expression ($ScoopFile + ' install hub')
#         # }
#     }
#     'Unix'
#     {
#         # brew install hub
#     }
# }