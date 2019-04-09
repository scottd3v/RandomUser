Describe "New-RandomUserCustom" {

    It "Generates a random password" {

        $RandomPassword = New-RandomUserCustom -domain "RandomUser"
        $RandomPassword | Should -not -be $null

    }

}
