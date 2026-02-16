#!/usr/bin/env bash
set -euo pipefail

PAGEFIND_VERSION="${1:-}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SITE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
VENV_DIR="$SITE_DIR/.venv-pagefind"
PUBLIC_DIR="$SITE_DIR/public"

if [ -z "$PAGEFIND_VERSION" ]; then
  echo "Error: PAGEFIND_VERSION not provided"
  exit 1
fi

if [ ! -d "$PUBLIC_DIR" ]; then
  echo "Error: public directory not found at $PUBLIC_DIR"
  exit 1
fi

if [ ! -d "$VENV_DIR" ]; then
  python3 -m venv "$VENV_DIR"
fi

source "$VENV_DIR/bin/activate"

INSTALLED_VERSION=$(pip show pagefind 2>/dev/null | grep "^Version:" | awk '{print $2}' || echo "")

if [ "$INSTALLED_VERSION" != "$PAGEFIND_VERSION" ]; then
  pip install "pagefind[bin]==$PAGEFIND_VERSION"
fi

python3 -m pagefind --site "$PUBLIC_DIR"
echo -e "Pagefind index built successfully"
