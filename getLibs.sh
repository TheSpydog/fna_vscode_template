#!/bin/sh
# getLibs
# Downloads the latest archive of pre-compiled native libraries for FNA,
# 	and installs them in /usr/local/lib so Mono can easily reference them.
# Usage: ./getLibs

# Downloading
echo "Downloading latest fnalibs..."
curl http://fna.flibitijibibo.com/archive/fnalibs.tar.bz2 > fnalibs.tar.bz2
if [ $? -eq 0 ]; then
	echo "Finished downloading!"
else
	echo "ERROR: Unable to download successfully. Maybe try again later?"
	exit 1
fi

# Decompressing
echo "Decompressing fnalibs..."
mkdir fnalibs
tar xjC fnalibs -f fnalibs.tar.bz2
rm fnalibs.tar.bz2
echo "Finished decompressing!"

# Copying
echo "Copying fnalibs to /usr/local/libs..."
cp ./fnalibs/osx/* /usr/local/lib
if [ $? -eq 0 ]; then
	echo "Successfully installed!"
else
	echo "ERROR: Unable to copy fnalibs successfully."
	exit 1
fi
