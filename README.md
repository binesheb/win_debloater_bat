# Windows Debloater (Batch)

A small, interactive Windows batch utility for removing selected built-in app packages. The project is intentionally lightweight and keeps the removal choices visible before making changes.

> **Use with care.** Removing built-in applications can affect Windows features and may require Microsoft Store, Windows Update, or other recovery steps to restore. Create a restore point or other backup before changing a production machine.

## Current status

This is a legacy utility originally created in 2023. The current maintenance goal is to make usage and updates safer without changing the project's lightweight batch-file design unnecessarily.

## Run

1. Review the batch file before running it.
2. Right-click `Remove Windows Bloatware.bat` and run it from an elevated Command Prompt when package removal requires administrator rights.
3. Select only the applications you intend to remove.
4. Confirm the displayed selection.

## Update

### Manual update

```bat
git pull --ff-only
```

If you do not have Git, download a known revision from this repository and replace the existing script only after reviewing the changes.

For reproducibility, pin a known-good revision:

```bat
git fetch --tags --prune
git checkout <tag-or-commit>
```

Rollback is simply a checkout of the previously known-good tag or commit.

### Automatic update policy

This repository does **not** silently self-update the debloater. A system-cleanup tool should not replace its own removal logic immediately before making destructive changes. GitHub remains the source of truth; future automatic update checks should compare the installed revision with a versioned GitHub release, show the user what will change, and require explicit confirmation before installing.

## Versioning and releases

Semantic Versioning is used for future maintained releases:

- **PATCH**: documentation, safety, or compatible bug fixes.
- **MINOR**: backward-compatible removal options or usability improvements.
- **MAJOR**: breaking changes to behavior, supported Windows versions, or the execution model.

See [CHANGELOG.md](CHANGELOG.md) for release notes.

## Next maintenance priorities

- Replace display-name matching with explicit package identifiers and verify current Windows compatibility.
- Add safer preflight checks and clearer per-package success/failure reporting.
- Add an optional update checker that uses versioned releases without unattended script replacement.
