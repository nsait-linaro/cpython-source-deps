
cmd.exe /c "call `"C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars32.bat`" && set > %temp%\vcvars32.txt"
Get-Content "$env:temp\vcvars$vcvarsarch.txt" | Foreach-Object {
    if ($_ -match "^(.*?)=(.*)$") {
        Set-Content "env:\$($matches[1])" $matches[2]
    }
}

Set-Location $PSScriptRoot

Set-Location .\win

nmake -f makefile.vc all


