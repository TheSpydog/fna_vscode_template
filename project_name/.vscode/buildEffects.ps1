# Compiles all .fx files found in the project's Content directory.
# Intended for usage with VS Code Build Tasks tooling.
# You may need to change the path to fxc.exe depending on your installation.

Write-Output "Starting build process..."

Get-ChildItem ".\Content\" -R -Filter *.fx | 
Foreach-Object {
    $fileFullname = $_.FullName
    $fileBasename = $_.BaseName
    $fileDirectory = $_.Directory.FullName
    
    & 'C:\Program Files (x86)\Microsoft DirectX SDK (June 2010)\Utilities\bin\x86\fxc.exe' `
    /T fx_2_0 $fileFullname /Fo "$fileDirectory\$fileBasename.fxb"

    Write-Output ""
}