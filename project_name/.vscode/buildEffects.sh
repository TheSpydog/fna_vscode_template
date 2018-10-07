#!/bin/bash
# Compiles all .fx files found in the project's Content directory.
# Intended for usage with VS Code Build Tasks tooling.
# You may need to change the path to fxc.exe depending on your installation.

printf "Starting build process...\n"

for file in `find ./Content/** -name "*.fx"` ;
do
    # Hush, wine...
    export WINEDEBUG=fixme-all,err-all

    # Build the effect
    wine ~/.wine/drive_c/Program\ Files/Microsoft\ DirectX\ SDK\ \(June\ 2010\)/Utilities/bin/x86/fxc.exe\
     /T fx_2_0 $file /Fo "`dirname $file`/`basename $file .fx`.fxb"

    echo ""

done