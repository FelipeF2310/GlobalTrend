# GlobalTrend – Claude Code Guide

This file provides context and instructions for Claude Code when working in this repository.

## Project Overview

**Repository:** FelipeF2310/GlobalTrend
**Branch convention:** Feature branches use the prefix `claude/` (e.g. `claude/feature-name-<id>`).

## Development Workflow

- All changes should be developed on the designated feature branch.
- Commit messages should be clear and descriptive.
- Push to the remote branch when changes are complete.
- Never push to `main`/`master` without an explicit pull request.

## Session Start Hook

A `SessionStart` hook is configured at `.claude/hooks/session-start.sh`. It automatically installs project dependencies when a new remote (Claude Code on the web) session starts.

The hook detects and installs:
- **Node.js** – runs `npm install` if `package.json` is present
- **Python** – runs `pip install -r requirements.txt` or `pip install -e .`
- **Ruby** – runs `bundle install` if `Gemfile` is present
- **Go** – runs `go mod download` if `go.mod` is present
- **Rust** – runs `cargo fetch` if `Cargo.toml` is present

To add new dependency types, edit `.claude/hooks/session-start.sh`.

## Code Style

- Follow the conventions already established in the codebase.
- Keep changes focused and minimal – only modify what is necessary for the task.
- Prefer editing existing files over creating new ones.
- Do not add unnecessary comments, docstrings, or type annotations to unchanged code.

## Testing & Linting

Run tests and linters before committing. Add specific commands here as the project grows:

```bash
# Example – update these to match the actual project toolchain
npm test          # Node.js
pytest            # Python
go test ./...     # Go
cargo test        # Rust
```

## Git Practices

- Stage specific files rather than `git add -A` to avoid committing secrets or binaries.
- Never amend published commits – create new commits instead.
- Do not skip hooks (`--no-verify`).

## Security Notes

- Do not commit `.env` files, credentials, or secrets.
- Validate all external input at system boundaries.
- Follow OWASP Top 10 best practices.
