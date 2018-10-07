#!/bin/sh
# getFNA
# Clones/pulls the latest FNA from Github for use as a project reference.
# Usage: ./getFNA

git --version > /dev/null
if [ $? -eq 1 ]; then
	echo "ERROR: Git is required to pull FNA from the command line."
	echo "Either install git or download and unzip FNA manually."
	exit 1
fi

# Downloading
if [ ! -d "FNA" ]; then
	echo "Cloning FNA..."
	git clone https://github.com/FNA-XNA/FNA.git --recursive
	if [ $? -eq 0 ]; then
		echo "Finished cloning!"
	else
		echo "ERROR: Unable to clone successfully. Maybe try again later?"
		exit 1
	fi
else
	echo "Pulling the latest git version of FNA..."
	cd FNA
	git pull --recurse-submodules
	if [ $? -eq 0 ]; then
		echo "Finished updating!"
	else
		echo "ERROR: Unable to update."
		exit 1
	fi
fi