function Copy-FilePreservePath {
    [CmdletBinding()]
    param(
        [parameter(ValueFromPipeline, Mandatory=$true)]
        [string[]] $Files,
        [Parameter(Mandatory=$true)]
        [string] $Destination,
        [Parameter(Mandatory=$true)]
        [string] $basePath
    )
    
    begin {
        $basePathRegex = [regex]::Escape($basePath)
    }

    process {
        # Tirm basePath from current file to copy
        $currentFile = $_
        if ( $currentFile -match $basePathRegex ) {
            $newFile = Join-Path -Path $Destination -ChildPath ($currentFile -replace ".*$basePathRegex", "")
        } else {
            Write-Error "The file $currentFile does not belong to the base directory $basePath"
        }

        # if this directory structure does not exist, create it
        if ( !(Test-Path ($newFile)) ) {
            New-Item -Path $newFile -ItemType "File" -Force | Out-Null
        }

        # Copy file
        Copy-Item -Path $_ -Destination $newFile
    }

    end {

    }

}
