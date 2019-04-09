Describe "New-RandomPassword" {

    It "Generates a random password" {

        $RandomPassword = New-RandomPassword
        $RandomPassword | Should -not -be $null

    }

}
