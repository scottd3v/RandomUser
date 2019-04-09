Describe "Connect-RandomUser" {

    It "Connects to RandomUser an API key using" {

        $Connect = Connect-RandomUser -APIKey $RandomUser_APIKey -force
        $Connect | Should -be $null

    }

}
