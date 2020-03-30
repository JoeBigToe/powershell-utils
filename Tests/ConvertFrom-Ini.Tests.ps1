# Test line to check if bitbucket -> jenkins connection is working

$moduleName = 'PSUtils'

$modulePath = $MyInvocation.MyCommand.Path -replace '\\Tests\\.*', "\$moduleName"
$sutName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
$sutPath = gci -recurse -file -Path $modulePath -Filter $sutName | select -expand "fullname"
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$global:test_data = "$here\data"

Import-Module -Force $modulePath

InModuleScope $moduleName {

    context "When input message is well formatted" {

        $message = Get-Content "$global:test_data\well-formatted.ini"

        Describe "ConvertFrom-Ini" {

            $output = ConvertFrom-Ini $message

            it "Should return a hashtable" {

                $output | Should -BeOfType [hashtable]

            }
            
            it "Should return chapters and key values" {
                $output.chapter1.key1 | Should -Be "val1"
                $output.chapter2.key1 | Should -Be "val3"
            }

        }
    }
}