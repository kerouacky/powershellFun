# this script contains the commands that will be run on he remote machine

# declare an empty hash of powershell objects
[System.Collections.Generic.List[psobject]]$extensions = @()

if ($isLinux) {
    $homePath = '/home/'
} else {
    $homePath = "$($env:HOMEDRIVE)\Users"
}

$homeDirs = Get-ChildItem -Path $homePath -Directory  

foreach ($dir in $homeDirs) {
    $vscPath = Join-Path $dir.FullName '.vscode\extensions'
    if (Test-Path -Path $vscPath) {
        $ChildItem = @{
            Path = $vscPath
            Recurse = $true
            Filter = '.vsixmanifest'
            Force = $true
        }
        $manifests = Get-ChildItem @ChildItem

        foreach ($m in $manifests) {
            [xml]$vsix = Get-Content -Path $m.FullName
            $vsix.PackageManifest.MetaData.Identity | Select-Object -Property Id, Version, Publisher, @{l= 'Folder'; e= {$m.FullName}}, @{l= 'ComputerName'; e={[system.environment]::MachineName}}, @{l='Date'; e= {Get-Date}} | ForEach-Object {
                $extensions.Add($_)
            }
        }
    }
}

if ($extensions.Count -eq 0) {
    $extensions.Add([pscustomobject]@{
        Id = $null
        Version = $null
        Publisher = $null
        Folder = $null
        ComputerName = [system:environment]::MachineName
        Date = Get-Date
    }
}

$extensions

