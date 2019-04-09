Function New-RandomString ()
{
    [CmdletBinding()]

    param(

        [Parameter()] 
        [ValidateRange(0, 52)]
        [Int]
        $NumberOfChars = 8

    )
    begin {}
    process
    {
        $Random = -join ((65..90) + (97..122) | Get-Random -Count $NumberOfChars | % {[char]$_})
    }
    end {Return $Random}


}