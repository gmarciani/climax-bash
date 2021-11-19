#!/bin/sh
set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

cat "$PROJECT_DIR/../resources/file.txt"
