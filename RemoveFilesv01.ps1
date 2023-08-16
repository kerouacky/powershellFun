# fxn to remove filesfunction Remove-ArchivedFiles {

function Remove-ArchivedFiles {
    [CmdletBinding()]
    param (
        [CmdletBinding()]
        [OutputType()]

        [Parameter(Mandatory = $true)]
        [string]$ZipFile,

        [Parameter(Mandatory = $true)]
        [string]$FilesToDelete,

        [Parameter(Mandatory = $false)]
        [switch]$Whatif = $false
    )

    $AssemblyName = 'System.IO.Compression.FileSystem'
    Add-Type -AssemblyName $AssemblyName 
    
    # $OpenZip is the current zip file/archive
    $OpenZip = [System.IO.Compression.ZipFile]::OpenRead($ZipFile)
    $ZipFileEntries = $OpenZip.Entries  

    foreach ($file in $FilesToDelete) {
        $check = $ZipFileEntries | Where-Object{$_.Name -eq $file.Name -and $_.Length -eq $file.Length}

        if ($null -ne $check) {
            $file | Remove-Item -Force -WhatIf:$Whatif
        }
        else {
            
        }
    }

    
    
}