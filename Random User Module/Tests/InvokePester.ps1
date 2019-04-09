. "$PSScriptRoot/HelperFunctions.ps1"
. "$PSScriptRoot/TestEnvironmentVariables.ps1"

$RootPath = Split-Path $PSScriptRoot -Parent

$Private = @( Get-ChildItem -Path "$RootPath\Private\*.ps1" -Recurse )

Import-Module  "$RootPath/RandomUser.psd1"

Foreach ($Import in  $Private)
{
    Try
    {
        . $Import.FullName
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($Import.FullName): $_"
    }
}

$PesterResults = Invoke-Pester -Script @{ Path = $PSScriptRoot } -PassThru

$PesterResults

$PesterResults.TestResult | Where-Object Result -EQ Failed