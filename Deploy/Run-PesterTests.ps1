. ($PSScriptRoot + '/' + 'Get-Config.ps1')
Write-Host ('[status]Loaded config:' + $PSScriptRoot + $PathDeliminator + 'Get-Config.ps1')
###########################################################################
Write-Host ('[status]Installing module: Pester')
Install-Module -Name:('Pester') -Force -Scope:('CurrentUser')
Write-Host ('[status]Running pester tests in: ' + $Folder_Tests)
$PesterResults = Invoke-Pester -Script @{ Path = $Folder_Tests } -PassThru

If ($PesterResults.FailedCount -gt 0)
{
    $PesterResults
    Write-Error "Failed [$($PesterResults.FailedCount)] Pester tests"
}
Else
{
    Write-Host ('[success]Pester tests returned no failures')
}
