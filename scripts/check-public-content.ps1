param(
    [string]$RepositoryRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'

$textExtensions = @('.md', '.yaml', '.yml', '.json', '.toml', '.txt', '.svg')
$extensionlessTextFiles = @('Dockerfile')
$scanPaths = @('docs', 'deploy', 'README.md', 'mkdocs.yml', 'Dockerfile', 'docker-compose.yml')
$allowedCanonicalHostnameFiles = @(
    'deploy/base/httproute.yaml',
    'docs/docs.md'
)
$normalizedRepositoryRoot = [System.IO.Path]::GetFullPath($RepositoryRoot).TrimEnd(
    [System.IO.Path]::DirectorySeparatorChar,
    [System.IO.Path]::AltDirectorySeparatorChar
) + [System.IO.Path]::DirectorySeparatorChar

$checks = @(
    @{
        Name = 'RFC1918 address'
        Pattern = '(?<!\d)(?:10(?:\.\d{1,3}){3}|192\.168(?:\.\d{1,3}){2}|172\.(?:1[6-9]|2\d|3[01])(?:\.\d{1,3}){2})(?!\d)'
    },
    @{
        Name = 'multicast-DNS hostname'
        Pattern = '(?i)\b[a-z0-9_-]+(?:\.[a-z0-9_-]+)*\.local\b'
    },
    @{
        Name = 'local user path'
        Pattern = '(?i)(?:[a-z]:\\Users\\[^\\/\s]+|/mnt/[a-z]/Users/[^/\s]+|/home/[^/\s]+)'
    },
    @{
        Name = 'private key material'
        Pattern = '-----BEGIN (?:[A-Z ]+ )?PRIVATE KEY-----'
    },
    @{
        Name = 'non-example email address'
        Pattern = '(?i)\b[a-z0-9._%+-]+@(?!example\.com\b)[a-z0-9.-]+\.[a-z]{2,}\b'
    },
    @{
        Name = 'live VPN provider identity'
        Pattern = '(?i)\bNordVPN\b'
    }
)

$findings = [System.Collections.Generic.List[string]]::new()
$filesToScan = foreach ($scanPath in $scanPaths) {
    $absoluteScanPath = Join-Path $RepositoryRoot $scanPath
    if (Test-Path -LiteralPath $absoluteScanPath -PathType Container) {
        Get-ChildItem -LiteralPath $absoluteScanPath -Recurse -File
    } elseif (Test-Path -LiteralPath $absoluteScanPath -PathType Leaf) {
        Get-Item -LiteralPath $absoluteScanPath
    }
}

foreach ($file in $filesToScan | Sort-Object -Property FullName -Unique) {
    if (
        $textExtensions -notcontains $file.Extension.ToLowerInvariant() -and
        $extensionlessTextFiles -notcontains $file.Name
    ) {
        continue
    }

    $absolutePath = [System.IO.Path]::GetFullPath($file.FullName)
    if (-not $absolutePath.StartsWith($normalizedRepositoryRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to scan a path outside the repository: $absolutePath"
    }

    $relativePath = $absolutePath.Substring($normalizedRepositoryRoot.Length).Replace('\', '/')
    $lineNumber = 0

    foreach ($line in Get-Content -LiteralPath $file.FullName) {
        $lineNumber++

        foreach ($check in $checks) {
            if ($line -match $check.Pattern) {
                $findings.Add("${relativePath}:${lineNumber}: $($check.Name)")
            }
        }

        if (
            $line -match '(?i)\b(?:[a-z0-9-]+\.)*dbhomelab\.com\b' -and
            $allowedCanonicalHostnameFiles -notcontains $relativePath
        ) {
            $findings.Add("${relativePath}:${lineNumber}: canonical hostname outside its allowlist")
        }
    }
}

if ($findings.Count -gt 0) {
    Write-Error ("Public-content check failed:`n" + ($findings -join "`n"))
    exit 1
}

Write-Host 'Public-content check passed.'
