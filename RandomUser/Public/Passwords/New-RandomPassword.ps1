Function New-RandomPassword ()
{

    [CmdletBinding()]

    param(

        [Parameter()]
        [ValidateRange(8, 24)]
        [Int]
        $NumberOfChars = 8

    )
    begin {}
    process
    {
        $RandomUpperChars = -join ((65..90) | Get-Random -Count ($NumberOfChars - 3) | % {[char]$_})

        $RandomLowerChar = (97..122) | Get-Random -Count 1 | % {[char]$_}

        $RandomNumber = (0..9) | Get-Random -Count 1

        $Special = "!"

        [string]$Final = $RandomLowerChar + $RandomUpperChars + $RandomNumber + $Special
    }
    end
    {
        Return $Final
    }


}