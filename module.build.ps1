#vars used for module testing and tasks
#requires -Modules InvokeBuild, PSDeploy, BuildHelpers, PSScriptAnalyzer, PlatyPS, Pester
$script:ModuleName = 'MyModule'

$script:Source = Join-Path $BuildRoot $ModuleName
$script:Output = Join-Path $BuildRoot output
$script:Destination = Join-Path $Output $ModuleName
$script:ModulePath = "$Destination\$ModuleName.psm1"
$script:ManifestPath = "$Destination\$ModuleName.psd1"
$script:Imports = ( 'private', 'public', 'classes' )
$script:TestFile = "$PSScriptRoot\output\TestResults_PS$PSVersion`_$TimeStamp.xml"
$script:HelpRoot = Join-Path $Output 'help'

function TaskX($Name, $Parameters) {task $Name @Parameters -Source $MyInvocation}

#Task Default UnitTests
Task Default UnitTests

Task UnitTests {
    $TestResults = Invoke-Pester -Path Tests\ -PassThru
    if ($TestResults.FailedCount -gt 0)
    {
        Write-Error "Failed [$($TestResults.FailedCount)] Pester tests"
    }
}
