function Test-HashtablesAreEqual {
    param(
        [Hashtable] $first,
        [Hashtable] $second
    )

    $orderedFirst = $($first.keys | sort)
    $orderedSecond = $($second.keys | sort)

    $hasTheSameKeys = $(Compare-Object $orderedSecond $orderedFirst) -eq $null
    if ($hasTheSameKeys){
        $hasTheSameValues = $true
        foreach( $key in $first.keys) {
            $hasTheSameValues = $hasTheSameValues -and $($first[$key] -eq $second[$key])
        }
    } else {
        $hasTheSameKeys = $false
    }

    Write-Output $($hasTheSameKeys -and $hasTheSameValues)

}
