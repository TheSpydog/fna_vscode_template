# Program: win_getFNA
# Author: Caleb Cornett
# Usage: ./win_getFNA.ps1
# Description: Quick and easy way to install a local copy of FNA and its native libraries.
# NOTE: 7-Zip must be installed to decompress fnalibs.

# Checks if git is installed
function checkGit()
{
    git --version > $null 2>&1
    if ( -Not $? ) {
        Write-Error "ERROR: Git is required to pull FNA from the command line."
        Write-Output "Either install git or download and unzip FNA manually."
        exit 1
    }
}

# Clones FNA from the git master branch
function downloadFNA()
{
    checkGit
    Write-Output "Downloading FNA..."
    git -C $PSScriptRoot clone https://github.com/FNA-XNA/FNA.git --recursive
	if ($?) {
        Write-Output "Finished downloading!"
    }
	else {
        Write-Error "ERROR: Unable to download successfully. Maybe try again later?"
    }
}

# Pulls FNA from the git master branch
function updateFNA()
{
    checkGit
    Write-Output "Updating to the latest git version of FNA..."
    git -C $PSScriptRoot/FNA pull --recurse-submodules
	if ($?) {
        Write-Output "Finished updating!"
    }
	else {
		Write-Error "ERROR: Unable to update."
    }
}

function getLibs()
{
    # Downloading
    Write-Output "Downloading latest fnalibs..."
    Invoke-WebRequest -Uri https://fna.flibitijibibo.com/archive/fnalibs.tar.bz2 -OutFile $PSScriptRoot/fnalibs.tar.bz2
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
    & $7zip x -y $PSScriptRoot/fnalibs.tar.bz2 -o"$PSScriptRoot"
    & $7zip x -y $PSScriptRoot/fnalibs.tar -o"$PSScriptRoot/fnalibs" >$null

    if ($?)
    {
        Write-Output "Finished decompressing!"
        Remove-Item $PSScriptRoot/fnalibs.tar.bz2
        Remove-Item $PSScriptRoot/fnalibs.tar
    }
    else
    {
        Write-Error "ERROR: Unable to decompress successfully."
    }
}


# FNA
if ( -Not (Test-Path -Path "$PSScriptRoot/FNA") )
{
    $shouldDownload = Read-Host "Download FNA (y/n)? "
    if ($shouldDownload -match "^[Yy]$")
    {
        downloadFNA
    }
}
else 
{
    $shouldUpdate = Read-Host "Update FNA (y/n)? "
    if ($shouldUpdate -match "^[Yy]$")
    {
        updateFNA
    }
}

# FNALIBS
$shouldDownloadLibs = ""
if ( -Not (Test-Path -Path "$PSScriptRoot/fnalibs") )
{
    $shouldDownloadLibs = Read-Host "Download fnalibs (y/n)? "
}
else
{
    $shouldDownloadLibs = Read-Host "Redownload fnalibs (y/n)? "
}

if ($shouldDownloadLibs -match "^[Yy]$")
{
    getLibs
}