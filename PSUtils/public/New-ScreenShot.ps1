function New-ScreenShot
{
    param(    

        [Parameter(Mandatory=$true)]
        [string]$OutFile

    )


    Add-Type -AssemblyName System.Drawing
    Add-Type -AssemblyName System.Windows.Forms

    $codec = [Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.FormatDescription -eq "jpeg" }
    
    # Take a printscreen as of pressing the keyboard key
    [Windows.Forms.Sendkeys]::SendWait("{PrtSc}")        
    
    # Parse the screenshot
    $bitmap = [Windows.Forms.Clipboard]::GetImage()    
    $ep = New-Object Drawing.Imaging.EncoderParameters  
    $ep.Param[0] = New-Object Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality, [long]100)  
    
    # Set proper extension if file has it wrong
    if ( $OutFile -notmatch "(\.jpg$|\.jpeg$)") {
        $OutFile = "$OutFile.jpg"
    }

    # Store the screenshot
    $bitmap.Save($OutFile, $codec, $ep)

}