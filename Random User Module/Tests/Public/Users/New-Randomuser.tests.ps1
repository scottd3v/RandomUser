Describe "New-Randomuser" {

    It "Generates a random password" {

        $RandomPassword = New-Randomuser
        $RandomPassword | Should -not -be $null

    }

}
