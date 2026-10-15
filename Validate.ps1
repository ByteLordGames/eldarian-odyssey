param(
    [string]$Compiler = 'C:\Program Files\PureBasic\Compilers\pbcompiler.exe',
    [string]$CompilerX86 = 'C:\Program Files (x86)\PureBasic\Compilers\pbcompiler.exe'
)

$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $Compiler -PathType Leaf)) {
    throw "PureBasic ASM compiler not found: $Compiler"
}

function Invoke-Compiler {
    param([string]$CompilerPath, [string[]]$CompilerArguments)
    & $CompilerPath @CompilerArguments
    if ($LASTEXITCODE -ne 0) {
        throw "PureBasic failed with exit code $LASTEXITCODE"
    }
}

Push-Location $PSScriptRoot
try {
    New-Item -ItemType Directory -Path Binaries -Force | Out-Null
    Write-Host 'Checking application source...'
    Invoke-Compiler -CompilerPath $Compiler -CompilerArguments @('EldarianOdyssey.pb', '/CHECK')
    Write-Host 'Building Windows x64 release...'
    Invoke-Compiler -CompilerPath $Compiler -CompilerArguments @('EldarianOdyssey.pb', '/OUTPUT', 'Binaries\EldarianOdyssey-x64.exe', '/ICON', 'Resources\icons\EO_Icon.ico', '/RESOURCE', 'Resources\EO_Version_Release.rc', '/XP', '/USER')
    Write-Host 'Building Windows x64 with debugger...'
    Invoke-Compiler -CompilerPath $Compiler -CompilerArguments @('EldarianOdyssey.pb', '/OUTPUT', 'Binaries\EldarianOdyssey-x64-Debug.exe', '/ICON', 'Resources\icons\EO_Icon.ico', '/RESOURCE', 'Resources\EO_Version_Debug.rc', '/XP', '/USER', '/DEBUGGER')
    Write-Host 'Building and running parser/state regressions...'
    Invoke-Compiler -CompilerPath $Compiler -CompilerArguments @('RegressionTests.pb', '/OUTPUT', 'Binaries\RegressionTests.exe', '/CONSOLE', '/LINENUMBERING')
    & .\Binaries\RegressionTests.exe
    if ($LASTEXITCODE -ne 0) {
        throw "Regression tests failed with exit code $LASTEXITCODE"
    }
    if (Test-Path -LiteralPath $CompilerX86 -PathType Leaf) {
        Write-Host 'Checking application source with Windows x86 compiler...'
        Invoke-Compiler -CompilerPath $CompilerX86 -CompilerArguments @('EldarianOdyssey.pb', '/CHECK')
        Write-Host 'Building Windows x86 release...'
        Invoke-Compiler -CompilerPath $CompilerX86 -CompilerArguments @('EldarianOdyssey.pb', '/OUTPUT', 'Binaries\EldarianOdyssey-x86.exe', '/ICON', 'Resources\icons\EO_Icon.ico', '/RESOURCE', 'Resources\EO_Version_X86_Release.rc', '/XP', '/USER')
        Write-Host 'Building Windows x86 with debugger...'
        Invoke-Compiler -CompilerPath $CompilerX86 -CompilerArguments @('EldarianOdyssey.pb', '/OUTPUT', 'Binaries\EldarianOdyssey-x86-Debug.exe', '/ICON', 'Resources\icons\EO_Icon.ico', '/RESOURCE', 'Resources\EO_Version_X86_Debug.rc', '/XP', '/USER', '/DEBUGGER')
        Write-Host 'Building and running x86 parser/state regressions...'
        Invoke-Compiler -CompilerPath $CompilerX86 -CompilerArguments @('RegressionTests.pb', '/OUTPUT', 'Binaries\RegressionTests-x86.exe', '/CONSOLE', '/LINENUMBERING')
        & .\Binaries\RegressionTests-x86.exe
        if ($LASTEXITCODE -ne 0) {
            throw "x86 regression tests failed with exit code $LASTEXITCODE"
        }
    }
    else {
        Write-Host "Windows x86 compiler not found at $CompilerX86; x86 validation skipped."
    }
    Write-Host 'Validation passed. The graphical game was not launched by this script.'
}
finally {
    Pop-Location
}
