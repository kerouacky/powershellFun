# Function to create new module

function New-ModuleTemplate {
    [CmdletBinding()]
    [OutputType()]

    param (
        [Parameter(Mandatory = $true)]
        [string]$ModuleName,

        [Parameter(Mandatory = $true)]
        [string]$ModuleVersion,

        [Parameter(Mandatory = $true)]
        [string]$Author,

        [Parameter(Mandatory = $true)]
        [string]$PSVersion,

        [Parameter(Mandatory = $true)]
        [string[]]$Functions
    )

    $ModulePath = Join-Path .\ "$($ModuleName)\$($ModuleVersion)"
    New-Item -Path $ModulePath -ItemType Directory

    # create a dictionary for manifest parameters
    $ManifestParameters = @{
        ModuleVersion = $ModuleVersion
        Author = $Author
        Path = ".\$($ModuleName)\$($ModuleName).psd1"    # the path to the manifest file
        RootModule = ".\$($ModuleName).psm1"            # the module itself--usually used to contain the functions but now the convention is to separate functions out in their own file (with the file named after the function itself)

        PowerShellVersion = $PSVersion
    }

        # call the built-in commandlet for building module Manifest file

        New-ModuleManifest $ManifestParameters

        $File = @{
            Path = ".\$($ModuleName).psm1"
            Encoding = "utf8"
        }
    }



    
}