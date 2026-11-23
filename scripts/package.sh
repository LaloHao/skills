#!/usr/bin/env bash
# Packages each skill in skills/ as dist/<skill>.zip for upload to claude.ai.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$root/dist"

for dir in "$root"/skills/*/; do
  name="$(basename "$dir")"
  if [[ ! -f "$dir/SKILL.md" ]]; then
    echo "skipped: $name (no SKILL.md)" >&2
    continue
  fi
  rm -f "$root/dist/$name.zip"
  (cd "$root/skills" && zip -qr "$root/dist/$name.zip" "$name" -x '*.DS_Store')
  echo "dist/$name.zip"
done
