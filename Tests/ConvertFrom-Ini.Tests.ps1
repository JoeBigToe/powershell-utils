# Test line to check if bitbucket -> jenkins connection is working

$moduleName = 'PSUtils'

$modulePath = $MyInvocation.MyCommand.Path -replace '\\Tests\\.*', "\$moduleName"
$sutName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
$sutPath = gci -recurse -file -Path $modulePath -Filter $sutName | select -expand "fullname"
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

Import-Module -Force $modulePath

InModuleScope $moduleName {
    Describe "ConvertFrom-Ini" {

        it "Should return a hashtable" {

            ConvertFrom-Ini "test" | Should -BeOfType [hashtable]

        } 

    }

}