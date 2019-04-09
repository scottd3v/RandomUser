. ((Get-Item -Path:($PSScriptRoot)).Parent.FullName + '\' + 'Get-Config.ps1')
Write-Host ('[status]Loaded config:' + (Get-Item -Path:($PSScriptRoot)).Parent.FullName + $PathDeliminator + 'Get-Config.ps1')
###########################################################################
# # Describe "Function Format Tests" {
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
# #     Context 'Function Format Tests' {
# #         It 'Passes FunctionReport' {
$Results = @()
# With in the Private and Public folders:
$FunctionList = Get-FunctionReport -Folder:($Folder_Private, $Folder_Public)
# Validate that there is only 1 function per file
$Results += $FunctionList.Where( { ($_.Function).Count -gt 1 -or ($_.MatchValue).Count -gt 1 }) | Select-Object @{Name = 'Status'; Expression = { 'Multiple functions exist in the file' } } , *
# The file name matches the function name
$Results += $FunctionList.Where( { $_.FileBaseName -ne $_.Function -or $_.FileBaseName -ne $_.MatchValue }) | Select-Object @{Name = 'Status'; Expression = { 'File name does not match the function name' } } , *
# That all file names names and function names are unique and that there are no duplicates
$Results += $FunctionList.Where( $_.FileBaseName -contains (($FunctionList.FileBaseName | Group-Object).Where( { $_.Count -gt 1 }).Name) ) | Select-Object @{Name = 'Status'; Expression = { 'Duplicate functions found' } } , *
$Results += $FunctionList.Where( $_.Function -contains (($FunctionList.Function | Group-Object).Where( { $_.Count -gt 1 }).Name) ) | Select-Object @{Name = 'Status'; Expression = { 'Duplicate functions found' } } , *
$Results += $FunctionList.Where( $_.MatchValue -contains (($FunctionList.MatchValue | Group-Object).Where( { $_.Count -gt 1 }).Name) ) | Select-Object @{Name = 'Status'; Expression = { 'Duplicate functions found' } } , *
# #     $Results | Should BeNullOrEmpty
# #     $? | Should Be $true
# # }
If ($Results)
{
    $Results | Select-Object Status, FolderLocation, FileName, LineNumber, FileBaseName, Function, MatchValue | Format-Table #, Line
    Write-Error ('Go fix the ValidateFunctionFiles results!')
}
Else
{
    Write-Host ('[success]ValidateFunctionFiles returned no results')
}
# #     }
# # }