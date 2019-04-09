. ((Get-Item -Path:($PSScriptRoot)).Parent.FullName + '\' + 'Get-Config.ps1')
Write-Host ('[status]Loaded config:' + (Get-Item -Path:($PSScriptRoot)).Parent.FullName + $PathDeliminator + 'Get-Config.ps1')
###########################################################################
# # Describe "Module Manifest Tests" {
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
# #     Context 'Module Manifest Tests' {
# #         It 'Passes Test-ModuleManifest' {
# #             Test-ModuleManifest -Path:($File_Psm1) | Should Not BeNullOrEmpty
# #             $? | Should Be $true
# #         }
# #     }
# # }

Test-ModuleManifest -Path:($File_Psm1)