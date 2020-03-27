# Refer to this website to see how these functions work:
# https://blogs.technet.microsoft.com/heyscriptingguy/2011/08/20/use-powershell-to-work-with-any-ini-file/
#

# TODO: Add test coverage to these functions
# TODO: Add comment-based help
# TODO: Add switch to tell if the hashtable is ordered or not

function Get-IniContentFromFile ($filePath){
    $ini = [ordered]@{}
    switch -regex -file $FilePath
    {
        "^\[(.+)\]" # Section
        {
            $section = $matches[1]
            $ini[$section] = [ordered]@{}
            $CommentCount = 0
        }
        "^(;.*)$" # Comment
        {
            $value = $matches[1]
            $CommentCount = $CommentCount + 1
            $name = "Comment" + $CommentCount
            $ini[$section][$name] = $value
        }
        "(.+?)\s*=(.*)" # Key
        {
            $name,$value = $matches[1..2]
            $ini[$section][$name] = $value
        }
    }
    return $ini
}

function Out-IniFile($InputObject, $FilePath){
    $outFile = New-Item -ItemType file -Path $Filepath -force
    foreach ($i in $InputObject.keys)
    {
        #if (!($($InputObject[$i].GetType().Name) -eq "Hashtable"))
        if (!($($InputObject[$i].GetType().Name) -in @("Hashtable", "OrderedDictionary")))
        {
            #No Sections
            Add-Content -Path $outFile -Value "$i=$($InputObject[$i])"
        } else {
            #Sections
            Add-Content -Path $outFile -Value "[$i]"
            #Foreach ($j in ($InputObject[$i].keys | Sort-Object))
            Foreach ($j in $InputObject[$i].keys)
            {
                if ($j -match "^Comment[\d]+") {
                    Add-Content -Path $outFile -Value "$($InputObject[$i][$j])"
                } else {
                    Add-Content -Path $outFile -Value "$j=$($InputObject[$i][$j])"
                }

            }
            Add-Content -Path $outFile -Value ""
        }
    }
}

function ConvertFrom-Ini($message) {
    $ini = [ordered]@{}
    switch -regex ($message)
    {
        "^\[(.+)\]" # Section
        {
            $section = $matches[1]
            $ini[$section] = [ordered]@{}
            $CommentCount = 0
        }
        "^(;.*)$" # Comment
        {
            $value = $matches[1]
            $CommentCount = $CommentCount + 1
            $name = "Comment" + $CommentCount
            $ini[$section][$name] = $value
        }
        "(.+?)\s*=(.*)" # Key
        {
            $name,$value = $matches[1..2]
            $ini[$section][$name] = $value
        }
    }
    return $ini
}

function ConvertTo-Ini($InputObject) {

    $output = ''
    $carriageReturn = "`r`n"

    foreach ($i in $InputObject.keys)
    {
        if (!($($InputObject[$i].GetType().Name) -in @("Hashtable", "OrderedDictionary")))
        {
            #No Sections
            $output += "$i=$($InputObject[$i])" + $carriageReturn
        } else {
            #Sections
            $output += "[$i]" + $carriageReturn

            Foreach ($j in $InputObject[$i].keys)
            {
                if ($j -match "^Comment[\d]+") {
                    $output += "$($InputObject[$i][$j])" + $carriageReturn
                } else {
                    $output += "$j=$($InputObject[$i][$j])" + $carriageReturn
                }

            }
            $output += $carriageReturn
        }
    }

    Write-Output $output
}