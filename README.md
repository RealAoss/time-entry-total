# Time Entry Total

Sum durations written as hours and minutes for a timesheet.

## Run

In PowerShell 7+, run `./run.ps1 -InputFile ./example.txt`. Pass `-OutputFile ./result.txt` to save to a new file. Existing output files are protected.

## Example

One duration per line (h:mm). The bundled example output includes:

```text
4 h 25 min
```

## Limitations

Input records are read from a UTF-8 text file. Blank lines are skipped.

## Development

See [CONTRIBUTING.md](CONTRIBUTING.md) for checks and [CHANGELOG.md](CHANGELOG.md) for changes.

## License

[MIT License](LICENSE). Copyright (c) 2026 time-entry-total contributors.
