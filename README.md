# Windows Debloater (Batch)

A small, interactive Windows batch utility for removing selected built-in Appx packages. The project is intentionally lightweight and keeps the removal choices visible before making changes.

> **Use with care.** Removing built-in applications can affect Windows features and may require Microsoft Store, Windows Update, or other recovery steps to restore. Create a restore point or other backup before changing a production machine.

## Current status

This is a legacy utility originally created in 2023. The current maintenance goal is to make usage and updates safer without changing the project's lightweight batch-file design unnecessarily.

The removal list now uses explicit Appx package identifiers rather than display-name pattern matching, which makes package targeting more predictable and avoids malformed wildcard commands.

## Run

1. Review the batch file before running it.
2. Right-click `Remove Windows Bloatware.bat` and run it from an elevated Command Prompt when package removal requires administrator rights.
3. Select only the applications you intend to remove.
4. Confirm the displayed selection.
5. Review per-package results before closing the window.

## Update

### Manual update

```bat
git pull --ff-only origin main
```

If you do not have Git, download a known revision from this repository and replace the existing script only after reviewing the changes.

For reproducibility, pin a known-good revision:

```bat
git fetch --tags --prune
git checkout <tag-or-commit>
```

Rollback is simply a checkout of the previously known-good tag or commit.

### Automatic update policy

This repository does **not** silently self-update the debloater. A system-cleanup tool should not replace its own removal logic immediately before making destructive changes. GitHub `main` remains the source of truth for any future update check, but installation must show the user what will change and require explicit confirmation.

## Dependencies and maintenance

The utility uses Windows PowerShell/Appx cmdlets already provided by supported Windows installations and has no package-managed runtime dependencies. If new dependencies are introduced, they must be actively maintained and must not be deprecated or abandoned.

## Versioning and releases

Semantic Versioning is used for future maintained releases:

- **PATCH**: documentation, safety, or compatible bug fixes.
- **MINOR**: backward-compatible removal options or usability improvements.
- **MAJOR**: breaking changes to behavior, supported Windows versions, or the execution model.

See [CHANGELOG.md](CHANGELOG.md) for release notes.

## Next maintenance priorities

- Verify the explicit package identifiers against current Windows 10 and Windows 11 builds.
- Add safer preflight checks and clearer per-package success/failure reporting.
- Add an optional `main`-based update checker that requires explicit confirmation before replacing the script.
