. ((Get-Item -Path:($PSScriptRoot)).Parent.FullName + '\' + 'Get-Config.ps1')
Write-Host ('[status]Loaded config:' + (Get-Item -Path:($PSScriptRoot)).Parent.FullName + $PathDeliminator + 'Get-Config.ps1')
###########################################################################
# # Describe "PSScriptAnalyzer Tests" {
# #     BeforeAll {
# #         # $DebugPreference = 'Continue'
# #         # $VerbosePreference = 'Continue'
# #         $ErrorActionPreference = 'Stop'
# #     }
# #     AfterAll {
# #         # $DebugPreference = 'SilentlyContinue'
# #         # $VerbosePreference = 'SilentlyContinue'
# #         $ErrorActionPreference = 'Continue'
# #     }
# #     Context 'PSScriptAnalyzer Tests' {
# #         It 'Passes Invoke-PSScriptAnalyzer' {
Write-Host ('[status]Installing module: PSScriptAnalyzer')
Install-Module -Name:('PSScriptAnalyzer') -Force -Scope:('CurrentUser')
Write-Host ('[status]Running PSScriptAnalyzer on: ' + $Folder_Module)
$ScriptAnalyzerResults = Invoke-ScriptAnalyzer -Path:($Folder_Module) -Recurse
# #     $ScriptAnalyzerResults | Should BeNullOrEmpty
# #     $? | Should Be $true
# # }
If ($ScriptAnalyzerResults)
{
    $ScriptAnalyzerResults
    Write-Error ('Go fix the ScriptAnalyzer results!')
}
Else
{
    Write-Host ('[success]ScriptAnalyzer returned no results')
}
# #     }
# # }