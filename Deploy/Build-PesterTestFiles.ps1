. ($PSScriptRoot + '\' + 'Get-Config.ps1')
Write-Host ('[status]Loaded config:' + $PSScriptRoot + $PathDeliminator + 'Get-Config.ps1')
###########################################################################
Write-Host ('[status]Creating files for Pester tests')
$Files = $Functions_Public + $Functions_Private
Foreach ($File in $Files)
{
    $NewDirectory = ([string]$File.Directory).Replace($Folder_Module, $Folder_Tests)
    $NewName = $File.BaseName + '.Tests' + $File.Extension
    $NewFullName = $NewDirectory + $PathDeliminator + $NewName
    New-FolderRecursive -Path:($NewFullName)
    If ( !( Test-Path -Path:($NewFullName) ))
    {
        Write-Host ('[status]Create test files for new function')
        New-Item -ItemType:('File') -Path:($NewFullName) -Force
    }
}
