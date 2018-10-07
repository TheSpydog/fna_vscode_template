# getLibs_Win
# Downloads and untars the latest archive of pre-compiled native libraries for FNA.
# Note: This requires 7-Zip to be installed.
# Usage: ./getLibs

# Downloading
Write-Output "Downloading latest fnalibs..."
Invoke-WebRequest -Uri http://fna.flibitijibibo.com/archive/fnalibs.tar.bz2 -OutFile fnalibs.tar.bz2
if ($?) {
    Write-Output "Finished downloading!"
}
else {
    Write-Error "ERROR: Unable to download successfully. Maybe try again later?"
    exit 1
}

# Is 7Zip installed?
# Edit this to be Program Files (x86) if you installed the 32-bit version.
$7zip = 'C:\Program Files\7-Zip\7z.exe'
& $7zip >$null
if (-Not $?)
{
    Write-Error "7Zip is required to decompress fnalibs."
    exit 1
}

# Decompress
& $7zip x -y fnalibs.tar.bz2 >$null
& $7zip x -y fnalibs.tar -o* >$null

Remove-Item fnalibs.tar.bz2
Remove-Item fnalibs.tar

Write-Output "fnalibs extracted!"