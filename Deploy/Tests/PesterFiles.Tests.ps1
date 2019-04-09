. ((Get-Item -Path:($PSScriptRoot)).Parent.FullName + '\' + 'Get-Config.ps1')
Write-Host ('[status]Loaded config:' + (Get-Item -Path:($PSScriptRoot)).Parent.FullName + $PathDeliminator + 'Get-Config.ps1')
###########################################################################
# # Describe "Pester Test Tests" {
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
# #     Context 'Validating Pester test files have been populated' {
# #         It 'Passes Pester Test Files Validation' {
$Files = $Functions_Public + $Functions_Private
$PesterTestsPopulation = @()
Foreach ($File in $Files)
{
    $FileContent = Get-Content -Path:($File.FullName)
    If (!($FileContent))
    {
        $PesterTestsPopulation = $File.FullName
    }
}
# #     $PesterTestsPopulation | Should BeNullOrEmpty
# #     $? | Should Be $true
# # }
If ($PesterTestsPopulation)
{
    Write-Error ('Go populate the Pester tests file for: ' + ($PesterTestsPopulation -join ', '))
}
Else
{
    Write-Host ('[success]PesterTestsPopulation returned no results')
}
# #     }
# # }