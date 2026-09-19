# Integration checks against real junctions in an isolated, ignored directory.
$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
$installer = Join-Path $PSScriptRoot 'install.ps1'
$testRoot = Join-Path $repo ('.validation\install-' + [guid]::NewGuid().ToString('N'))
$destination = Join-Path $testRoot 'installed'
$skills = @(Get-ChildItem -LiteralPath (Join-Path $repo 'skills') -Directory)

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

& $installer -Destination $destination -WhatIf
Assert-True (-not (Test-Path -LiteralPath $destination)) 'WhatIf created a directory.'

& $installer -Destination $destination
& $installer -Destination $destination
foreach ($skill in $skills) {
    $link = Join-Path $destination $skill.Name
    Assert-True ((Get-Item -LiteralPath $link).LinkType -eq 'Junction') 'Expected a junction.'
    $sourceHash = (Get-FileHash -LiteralPath (Join-Path $skill.FullName 'SKILL.md')).Hash
    $linkedHash = (Get-FileHash -LiteralPath (Join-Path $link 'SKILL.md')).Hash
    Assert-True ($sourceHash -eq $linkedHash) 'Linked content differs from source.'
}

$unrelated = Join-Path $destination 'unrelated'
New-Item -ItemType Directory -Path $unrelated | Out-Null
Set-Content -LiteralPath (Join-Path $unrelated 'keep.txt') -Value 'preserve'
& $installer -Destination $destination -Uninstall -WhatIf
Assert-True (Test-Path -LiteralPath (Join-Path $destination $skills[0].Name)) 'WhatIf removed a link.'
& $installer -Destination $destination -Uninstall
& $installer -Destination $destination -Uninstall
foreach ($skill in $skills) {
    Assert-True (-not (Test-Path -LiteralPath (Join-Path $destination $skill.Name))) 'Uninstall left a link.'
    Assert-True (Test-Path -LiteralPath (Join-Path $skill.FullName 'SKILL.md')) 'Uninstall removed source content.'
}
Assert-True (Test-Path -LiteralPath (Join-Path $unrelated 'keep.txt')) 'Uninstall touched unrelated content.'

# A same-name real directory must block the entire install, even if encountered last.
$collision = Join-Path $destination $skills[-1].Name
New-Item -ItemType Directory -Path $collision | Out-Null
$blocked = $false
try { & $installer -Destination $destination } catch { $blocked = $true }
Assert-True $blocked 'An existing directory did not block installation.'
Assert-True (-not (Test-Path -LiteralPath (Join-Path $destination $skills[0].Name))) 'Preflight allowed a partial install.'
& $installer -Destination $destination -Uninstall
Assert-True (Test-Path -LiteralPath $collision) 'Uninstall deleted a real directory.'

# A same-name junction to another repo must survive uninstall and block install.
[IO.Directory]::Delete($collision) # Empty test directory only; no recursive deletion.
$foreign = Join-Path $testRoot 'foreign'
New-Item -ItemType Directory -Path $foreign | Out-Null
Set-Content -LiteralPath (Join-Path $foreign 'keep.txt') -Value 'preserve'
New-Item -ItemType Junction -Path $collision -Target $foreign | Out-Null
$blocked = $false
try { & $installer -Destination $destination } catch { $blocked = $true }
Assert-True $blocked 'An unrelated junction did not block installation.'
& $installer -Destination $destination -Uninstall
Assert-True (Test-Path -LiteralPath (Join-Path $collision 'keep.txt')) 'Uninstall touched an unrelated junction.'
[IO.Directory]::Delete($collision) # Remove only this test junction.

Write-Host 'PASS: dry run, install, idempotence, source preservation, collisions and unrelated links.'
