
function Get-XmlTagValue {
    param(
        [string] $file,
        [string] $tagFilter
    )

    
    [xml] $projectContent = get-content $file
    $xmlTag = "`$projectContent.{0}" -f $tagFilter

    if ( ($xmlTagValue = iex "$xmlTag") -ne $null) {

        if ($xmlTagValue.gettype().name -eq 'String') {
            Write-Output $xmlTagValue
        } else {
            Write-Error "The filter you applied, do not belong to a final XML node with text"
        }        

    } else {
        Write-Output ""
    }


}