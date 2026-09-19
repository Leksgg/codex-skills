<#
.SYNOPSIS
Links this repository's skills into the user's Codex skills directory.
.DESCRIPTION
Uses Windows junctions, without downloads or configuration changes.
Uninstall removes only links to the exact matching skill in this repository.
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$Destination = (Join-Path $env:USERPROFILE '.agents\skills'),
    [switch]$Uninstall
)

$ErrorActionPreference = 'Stop'
$repoSkills = [IO.Path]::GetFullPath((Join-Path (Split-Path $PSScriptRoot -Parent) 'skills'))
$destinationPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Destination)
$skills = @(Get-ChildItem -LiteralPath $repoSkills -Directory | Where-Object {
    Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') -PathType Leaf
})

function Test-ExpectedLink($Item, [string]$Expected) {
    if ($null -eq $Item -or $Item.LinkType -ne 'Junction') { return $false }
    $target = [string]@($Item.Target)[0]
    if (-not $target) { return $false }
    return [string]::Equals(
        [IO.Path]::GetFullPath($target).TrimEnd('\'),
        $Expected.TrimEnd('\'),
        [StringComparison]::OrdinalIgnoreCase
    )
}

# Preflight all names before creating any links. Never replace an existing skill.
if (-not $Uninstall) {
    foreach ($skill in $skills) {
        $link = Join-Path $destinationPath $skill.Name
        $existing = Get-Item -LiteralPath $link -Force -ErrorAction SilentlyContinue
        if ($null -ne $existing -and -not (Test-ExpectedLink $existing $skill.FullName)) {
            throw "Destination already exists and is not this repository's junction: $link"
        }
    }
    if (-not (Test-Path -LiteralPath $destinationPath)) {
        if ($PSCmdlet.ShouldProcess($destinationPath, 'Create skills directory')) {
            New-Item -ItemType Directory -Path $destinationPath -Force | Out-Null
        }
    }
}

foreach ($skill in $skills) {
    $link = Join-Path $destinationPath $skill.Name
    $existing = Get-Item -LiteralPath $link -Force -ErrorAction SilentlyContinue
    $matches = Test-ExpectedLink $existing $skill.FullName

    if ($Uninstall) {
        if ($matches -and $PSCmdlet.ShouldProcess($link, 'Remove junction only')) {
            # Non-recursive: removes the junction itself, never its target contents.
            [IO.Directory]::Delete($link)
            Write-Host "Removed $($skill.Name)"
        }
    } elseif ($matches) {
        Write-Host "Already installed: $($skill.Name)"
    } elseif ($null -ne $existing) {
        throw "Destination changed during installation: $link"
    } elseif ($PSCmdlet.ShouldProcess($link, "Link to $($skill.FullName)")) {
        New-Item -ItemType Junction -Path $link -Target $skill.FullName | Out-Null
        Write-Host "Installed $($skill.Name) -> $link"
    }
}
