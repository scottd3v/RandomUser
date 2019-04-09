Describe "New-RandomStringLower" {

    It "Generates a random password" {

        $RandomPassword = New-RandomStringLower
        $RandomPassword | Should -not -be $null

    }

}
