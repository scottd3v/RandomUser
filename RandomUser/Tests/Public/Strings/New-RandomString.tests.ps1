Describe "New-RandomString" {

    It "Generates a random password" {

        $RandomPassword = New-RandomString
        $RandomPassword | Should -not -be $null

    }

}
