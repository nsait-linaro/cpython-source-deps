<#
#>
Param(
    [switch]$x64,
    [switch]$arm64,
    [switch]$vs2008
)

$vcvarsarch = If($x64) { "x86_amd64" } ElseIf ($arm64) { "x86_arm64" } Else { "32" }
cmd.exe /c "call `"C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars$vcvarsarch.bat`" && set > %temp%\vcvars$vcvarsarch.txt"
Get-Content "$env:temp\vcvars$vcvarsarch.txt" | Foreach-Object {
    if ($_ -match "^(.*?)=(.*)$") {
        Set-Content "env:\$($matches[1])" $matches[2]
    }
}

Set-Location $PSScriptRoot

Set-Location .\win

nmake -f makefile.vc nmakehlp


