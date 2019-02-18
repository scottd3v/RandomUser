Describe 'Tests' {

  Describe 'Get-Win7CheckJC'{
      Context 'O/S is Windows 7' {

        function Get-Win7CheckJC {
          $object =  New-Object psobject -Property @{'OS Name' = 'Microsoft Windows 7 Ultimate'}
          return $object
        }

        It "should return True" {
          (Get-Win7CheckJC).'OS NAME' -match '7' | Should Be $true
        } # It
      } # Context
      Context 'O/S is NOT Windows 7' {

        function Get-Win7CheckJC {
        $object =  New-Object psobject -Property @{'OS Name' = 'Microsoft Windows 10 Pro'}
        return $object
        }

        It "should return False" {
          (Get-Win7CheckJC).'OS NAME' -match '7' | Should Be $false
        } # It
      } # Context
    }

}
