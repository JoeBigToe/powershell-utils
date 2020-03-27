
# TODO #1: Add test coverage to these functions
# TODO: Add comment-based help
# TODO: Add switch to tell if the hashtable is ordered or not

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