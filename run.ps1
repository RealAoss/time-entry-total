[CmdletBinding()]
param(
    [Parameter(Mandatory, Position=0)][string]$InputFile,
    [string]$OutputFile
)
$ErrorActionPreference = 'Stop'
$culture = [Globalization.CultureInfo]::InvariantCulture
try {
    $records = @(Get-Content -LiteralPath $InputFile -Encoding utf8 | ForEach-Object { $_.Trim() } | Where-Object { $_ })
    if (-not $records.Count) { throw 'The input file is empty.' }
    $result = @(& {
        [long]$minutes = 0
        foreach ($line in $records) {
            if ($line -notmatch '^(\d+):([0-5]\d)$') { throw 'Expected h:mm.' }
            $minutes += [long]$Matches[1] * 60 + [int]$Matches[2]
        }
        '{0} h {1} min' -f [math]::Floor($minutes / 60), ($minutes % 60)
        ($minutes / 60).ToString('0.00', $culture) + ' decimal hours'
    })
    if ($OutputFile) {
        $stream = [IO.File]::Open([IO.Path]::GetFullPath($OutputFile), 'CreateNew', 'Write')
        try {
            $bytes = [Text.Encoding]::UTF8.GetBytes(($result -join [Environment]::NewLine) + [Environment]::NewLine)
            $stream.Write($bytes, 0, $bytes.Length)
        } finally { $stream.Dispose() }
    } else { $result }
} catch {
    [Console]::Error.WriteLine($_.Exception.Message)
    exit 1
}
