#!/bin/bash
set -euo pipefail

# Only run in remote (Claude Code on the web) environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Install dependencies based on what manifests are present
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Node.js (npm)
if [ -f "$PROJECT_DIR/package.json" ]; then
  echo "Installing Node.js dependencies..."
  cd "$PROJECT_DIR" && npm install
fi

# Python (pip / requirements.txt)
if [ -f "$PROJECT_DIR/requirements.txt" ]; then
  echo "Installing Python dependencies (requirements.txt)..."
  pip install -r "$PROJECT_DIR/requirements.txt"
fi

# Python (pyproject.toml with pip)
if [ -f "$PROJECT_DIR/pyproject.toml" ] && [ ! -f "$PROJECT_DIR/requirements.txt" ]; then
  echo "Installing Python dependencies (pyproject.toml)..."
  pip install -e "$PROJECT_DIR"
fi

# Ruby (Bundler)
if [ -f "$PROJECT_DIR/Gemfile" ]; then
  echo "Installing Ruby dependencies..."
  cd "$PROJECT_DIR" && bundle install
fi

# Go
if [ -f "$PROJECT_DIR/go.mod" ]; then
  echo "Installing Go dependencies..."
  cd "$PROJECT_DIR" && go mod download
fi

# Rust
if [ -f "$PROJECT_DIR/Cargo.toml" ]; then
  echo "Fetching Rust dependencies..."
  cd "$PROJECT_DIR" && cargo fetch
fi

echo "Session start hook complete."
