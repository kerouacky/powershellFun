function Set-ArchiveFilePath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ZipPath,


        [Parameter(Mandatory = $true)]
        [string]$ZipPrefix,

        [Parameter(Mandatory = $true)]
        [datetime]$Date
    )
    
    # creating a DIRECTORY if directory des NOT exist
    if (-not (Test-Path $ZipPath)) {
        New-Item -Path $ZipPath -ItemType Directory | Out-Null
        Write-Verbose "Creating directory $ZipPath"
    }

    $timeString = $Date.ToString("yyyyMMdd")
    $ZipName = "$($ZipPrefix)$($timeString).zip"

    # $ZipFile includes the path AND the filename
    $ZipFile = Join-Path $ZipPath $ZipName
    
    if (Test-Path $ZipFile) {
        throw "the file $ZipFile already exists"
    }

    return $ZipFile   
    
}