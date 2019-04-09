. ((Get-Item -Path:($PSScriptRoot)).Parent.FullName + '\' + 'Get-Config.ps1')
Write-Host ('[status]Loaded config:' + (Get-Item -Path:($PSScriptRoot)).Parent.FullName + $PathDeliminator + 'Get-Config.ps1')
###########################################################################
# # Describe "Help File Tests" {
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
# #     Context 'Validating help file fields have been populated' {
# #         It 'Passes Help File Validation' {
$HelpFilePopulation = Get-ChildItem -Path:($Folder_Docs) | Select-String -Pattern:('(\{\{)(.*?)(\}\})')
# #     $HelpFilePopulation | Should BeNullOrEmpty
# #     $? | Should Be $true
# # }
If ($HelpFilePopulation)
{
    $HelpFilePopulation
    Write-Error ('Go populate the help files!')
}
Else
{
    Write-Host ('[success]HelpFilePopulation returned no results')
}
# # }
# # }