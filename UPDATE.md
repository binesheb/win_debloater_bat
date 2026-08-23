# Update Guide

## Scope

This repository contains a destructive Windows cleanup utility. Updates should never silently replace the removal logic immediately before it is executed.

## Manual update

From a clean working tree:

```bat
git fetch --tags --prune
git pull --ff-only origin main
```

Review the changes before running `Remove Windows Bloatware.bat`. For reproducible use, check out a known-good tag or commit instead of tracking `main` directly:

```bat
git checkout <tag-or-commit>
```

## Rollback

Return to the last known-good revision:

```bat
git checkout <previous-tag-or-commit>
```

If Git is not available, keep a reviewed copy of the previously working script before replacing it.

## Automatic updates

Automatic or unattended replacement is intentionally not supported. An optional future update checker may report that a newer revision exists, but it must show the target revision and require explicit user confirmation before any file is replaced.

## Before running an updated version

1. Review the diff or release notes.
2. Create a restore point or other suitable backup.
3. Confirm that every selected Appx package is still appropriate for the target Windows installation.
4. Run the script interactively and review per-package results.
