
# TODO: Add test coverage to these functions
# TODO: Add comment-based help
# TODO: Add switch to tell if the hashtable is ordered or not


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