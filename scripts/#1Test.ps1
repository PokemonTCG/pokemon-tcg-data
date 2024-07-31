Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\HtmlAgilityPack.1.11.61\lib\NetCore45\HtmlAgilityPack.dll"
if (-not [System.Reflection.Assembly]::LoadFile("C:\Program Files\PackageManagement\NuGet\Packages\HtmlAgilityPack.1.11.61\lib\NetCore45\HtmlAgilityPack.dll")) {
    Write-Output "Failed to load HtmlAgilityPack.dll"
} else {
    Write-Output "HtmlAgilityPack.dll loaded successfully"
}
