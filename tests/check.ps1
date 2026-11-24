$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot
$script = Join-Path $root 'run.ps1'
$example = Join-Path $root 'example.txt'
$out = Join-Path ([IO.Path]::GetTempPath()) ([Guid]::NewGuid().ToString())
try {
    & $script -InputFile $example -OutputFile $out
    $text = [IO.File]::ReadAllText($out).Replace("`r`n", "`n")
    if (!$text.Contains('4 h 25 min')) { throw "Unexpected output: $text" }
    $null = & pwsh -NoProfile -File $script -InputFile $example -OutputFile $out 2>&1
    if ($LASTEXITCODE -eq 0) { throw 'Expected an overwrite error.' }
} finally { if (Test-Path -LiteralPath $out) { Remove-Item -LiteralPath $out } }
