# getFNA_Win
# Clones/pulls the latest FNA from Github for use as a project reference.
# Usage: ./getFNA_Win.bat

git --version > $null
if ( -Not $? ) {
    Write-Error "ERROR: Git is required to pull FNA from the command line."
	Write-Output "Either install git or download and unzip FNA manually."
	exit 1
}

# Downloading
if ( -Not (Test-Path -Path "FNA") ) {
    Write-Output "Cloning FNA..."
    git clone https://github.com/FNA-XNA/FNA.git --recursive
	if ($?) {
        Write-Output "Finished cloning!"
    }
	else {
        Write-Error "ERROR: Unable to clone successfully. Maybe try again later?"
		exit 1
    }
}
else {
	Write-Output "Pulling the latest git version of FNA..."
    git -C FNA pull --recurse-submodules
	if ($?) {
        Write-Output "Finished updating!"
    }
	else {
		Write-Error "ERROR: Unable to update."
		exit 1
    }
}