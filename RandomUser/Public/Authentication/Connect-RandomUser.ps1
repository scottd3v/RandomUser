Function Connect-RandomUser ()
{
    [CmdletBinding(DefaultParameterSetName = 'Interactive')]

    param
    (
        [Parameter(
            ParameterSetName = 'force',
            Mandatory,
            ValueFromPipelineByPropertyName,
            Position = 0)]

        [string]$APIKey,


        [Parameter(
            ParameterSetName = 'force')]
        [Switch]
        $force,

        [string]$UserAgent = "RandomUser_1.3.0"
    )





    begin
    {
        $global:RUUserAgent = $UserAgent

        
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        

        $GitHubModuleInfoURL = 'https://github.com/scottd3v/RandomUser/blob/master/RandomUser/ModuleBanner.md' #Enter banner URL

        $ReleaseNotesURL = 'https://github.com/scottd3v/RandomUser/blob/master/RandomUser/ModuleChangelog.md' #Enter release notes URL
    }

    process
    {
    }

    end
    {
        $global:RUAPIKEY = $APIKey


        if ($PSCmdlet.ParameterSetName -eq 'Interactive')
        {

            Write-Host -BackgroundColor Green -ForegroundColor Black "Successfully connected to RandomUser"

            $GitHubModuleInfo = Invoke-WebRequest -uri  $GitHubModuleInfoURL -UseBasicParsing | Select-Object RawContent

            $CurrentBanner = ((((($GitHubModuleInfo -split "</a>Banner Current</h4>")[1]) -split "<pre><code>")[1]) -split "`n")[0]

            $OldBanner = ((((($GitHubModuleInfo -split "</a>Banner Old</h4>")[1]) -split "<pre><code>")[1]) -split "`n")[0]

            $LatestVersion = ((((($GitHubModuleInfo -split "</a>Latest Version</h4>")[1]) -split "<pre><code>")[1]) -split "`n")[0]


            $InstalledModuleVersion = Get-InstalledModule -Name RandomUser | Select-Object -ExpandProperty Version

            if ($InstalledModuleVersion -eq $LatestVersion)
            {

                Write-Host -BackgroundColor Green -ForegroundColor Black "$CurrentBanner Module version: $InstalledModuleVersion" 

            }

            elseif ($InstalledModuleVersion -ne $LatestVersion)
            {

                Write-Host "$OldBanner" 
                Write-Host -BackgroundColor Yellow -ForegroundColor Black  "Installed Version: $InstalledModuleVersion " -NoNewline
                Write-Host -BackgroundColor Green -ForegroundColor Black  " Latest Version: $LatestVersion "

                Write-Host  "`nWould you like to upgrade to version: $LatestVersion ?"

                $Accept = Read-Host  "`nEnter 'Y' if you wish to update to version $LatestVersion or 'N' to continue using version: $InstalledModuleVersion"


                if ($Accept -eq 'N')
                {

                    return #Exit the function
                }

                While ($Accept -notcontains 'Y')
                {

                    Write-Warning " Typo? $Accept != 'Y'"

                    $Accept = Read-Host "`nEnter 'Y' if you wish to update to the latest version or 'N' to continue using version: $InstalledModuleVersion `n"

                    if ($Accept -eq 'N')
                    {

                        return # Exist the function
                    }

                }


                if ($PSVersionTable.PSVersion.Major -eq '5')
                {

                    If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
                    {

                        Write-Warning "You must have Administrative rights to update the module! To retry close this PowerShell session and open a new PowerShell session with Administrator permissions (Right click the PowerShell application and select 'Run as Administrator') and run the Connect-RUOnline command."

                        Return

                    }

                    Uninstall-Module -Name RandomUser -RequiredVersion $InstalledModuleVersion

                    Install-Module -Name RandomUser -Scope CurrentUser
                }

                elseif ($PSVersionTable.PSVersion.Major -ge 6)
                {

                    if ($PSVersionTable.Platform -eq 'Unix')
                    {

                        Uninstall-Module -Name RandomUser -RequiredVersion $InstalledModuleVersion

                        Install-Module -Name RandomUser -Scope CurrentUser

                    }

                    elseif ($PSVersionTable.Platform -like "*Win*")
                    {

                        If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
                        {

                            Write-Warning "You must have Administrative rights to update the module! To retry close this PowerShell session and open a new PowerShell session with Administrator permissions (Right click the PowerShell application and select 'Run as Administrator') and run the Connect-RUOnline command."

                            Return

                        }

                        Uninstall-Module -Name RandomUser -RequiredVersion $InstalledModuleVersion

                        Install-Module -Name RandomUser -Scope CurrentUser

                    }

                }


                $UpdatedModuleVersion = Get-InstalledModule -Name RandomUser | Select-Object -ExpandProperty Version

                if ($UpdatedModuleVersion -eq $LatestVersion)
                {

                    Clear-Host

                    $ReleaseNotesRaw = Invoke-WebRequest -uri $ReleaseNotesURL -UseBasicParsing #for backwards compatibility

                    $ReleaseNotes = ((((($ReleaseNotesRaw.RawContent -split "</a>$LatestVersion</h2>")[1]) -split "<pre><code>")[1]) -split "</code>")[0]

                    Write-Host "Module updated to version: $LatestVersion`n"

                    Write-Host "Release Notes: `n"

                    Write-Host $ReleaseNotes

                    Write-Host "`nTo see the full release notes navigate to: `n" 
                    Write-Host "$ReleaseNotesURL`n"

                    Pause

                }

            }


        } #End if

    }#End endblock

}