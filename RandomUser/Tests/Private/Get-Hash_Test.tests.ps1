Describe "Get-Hash_Test" {

    It "Tests a private function" {

        $Results = Get-Hash_Test $Hash_Test
        $Results | Should -be $Hash_Test

    }

}
