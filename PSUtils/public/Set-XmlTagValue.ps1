function Set-XmlTagValue {
    param(
        [string] $file,
        [string] $outFile,
        [string] $tagFilter,
        [string] $newValue
    )

    if ( -not $outFile) { $outFile = $file }
    
    [xml] $projectContent = get-content $file
    $xmlTag = "`$projectContent.{0}" -f $tagFilter

    $xmlTagValue = iex $xmlTag

    if ($xmlTagValue.gettype().name -eq 'String') {
        
        $lastNodeName = ($xmlTag -split '\.')[-1]
        $xmlTag = $xmlTag -replace "$lastNodeName", "getElementsByTagName('$lastNodeName')"

        $xmlTagNode = iex $xmlTag
        $xmlTagNode.set_InnerText($newValue)

        $projectContent.Save($outFile)

    } else {
        Write-Error "The filter you applied, do not belong to a final XML node with text"
    }    

}