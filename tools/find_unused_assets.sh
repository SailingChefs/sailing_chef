#!/usr/bin/env bash
set -euo pipefail

# Find potentially unused assets in a Flutter project (macOS-friendly)
# Strategy: For each file under assets/, search for references in lib/, ios/, android/, web/, and pubspec.yaml.
# If no references are found, mark as "UNUSED?". This is a heuristic and may have false positives for dynamically
# constructed asset paths, or assets referenced indirectly (e.g., from JSON, Lottie, remote configs). Provide a
# whitelist to account for those.
#
# Usage:
#   tools/find_unused_assets.sh                         # run with defaults
#   tools/find_unused_assets.sh --ci                    # non-zero exit if unused assets found
#   tools/find_unused_assets.sh --basename-fallback     # also try matching just the filename (more false positives)
#   tools/find_unused_assets.sh --dir assets            # change root dir to scan
#   tools/find_unused_assets.sh --ext 'png,jpg,svg'     # set extensions to scan
#
# Whitelist: Create a file at .asset-whitelist.txt with one path per line (relative to repo root), e.g.:
#   assets/images/icons/app_icon.png
#   assets/images/background/splash@2x.png

SCAN_DIR="assets"
SEARCH_DIRS=(lib ios android web pubspec.yaml)
EXTS=(png jpg jpeg webp svg json gif ttf otf bmp)
STRICT=true
CI_MODE=false
WHITELIST_FILE=".asset-whitelist.txt"

usage() {
  cat <<EOF
Usage: $0 [--dir <scan_dir>] [--ext 'png,jpg,svg'] [--basename-fallback] [--ci]

Options:
  --dir <scan_dir>         Directory to scan for assets (default: assets)
  --ext 'e1,e2,...'        Comma-separated list of file extensions to consider (default: png,jpg,jpeg,webp,svg,json,gif,ttf,otf,bmp)
  --basename-fallback      Also search by just the filename if full path search finds nothing (more false positives)
  --ci                     Exit with non-zero if any unused assets are found

Notes:
  - Heuristic only; review results before deletion.
  - Add exceptions to .asset-whitelist.txt (repo root), one path per line.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dir) SCAN_DIR="$2"; shift 2;;
    --ext) IFS=',' read -r -a EXTS <<< "$2"; shift 2;;
    --basename-fallback) STRICT=false; shift;;
    --ci) CI_MODE=true; shift;;
    -h|--help) usage; exit 0;;
    *) echo "Unknown arg: $1" >&2; usage; exit 1;;
  esac
done

if [[ ! -d "$SCAN_DIR" ]]; then
  echo "Scan dir not found: $SCAN_DIR" >&2
  exit 2
fi

# Load whitelist
declare -A WHITELIST
if [[ -f "$WHITELIST_FILE" ]]; then
  while IFS= read -r line; do
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    WHITELIST["$line"]=1
  done < "$WHITELIST_FILE"
fi

join_exts() { local IFS='|'; printf '%s' "${EXTS[*]}"; }

UNUSED_COUNT=0
TOTAL=0

printf "Scanning %s for extensions: %s\n" "$SCAN_DIR" "${EXTS[*]}"
printf "Searching references in: %s\n" "${SEARCH_DIRS[*]}"

find_pattern=".*/.*\.($(join_exts))$"

while IFS= read -r -d '' f; do
  TOTAL=$((TOTAL+1))
  rel="$f"
  # Normalize to relative path from repo root if script is run elsewhere
  if [[ "$rel" != assets/* && -e "$rel" ]]; then
    rel=$(python3 - <<PY
import os,sys
print(os.path.relpath(sys.argv[1]))
PY
"$rel")
  fi

  # Whitelist check
  if [[ -n "${WHITELIST[$rel]:-}" ]]; then
    continue
  fi

  # Full path search (fixed string)
  if /usr/bin/grep -R -n -F --binary-files=without-match \
      --exclude-dir=build --exclude-dir=.dart_tool --exclude-dir=.git \
      -- "$rel" "${SEARCH_DIRS[@]}" >/dev/null 2>&1; then
    continue
  fi

  # Optional fallback: search just by basename
  if [[ "$STRICT" == false ]]; then
    base=$(basename "$rel")
    if /usr/bin/grep -R -n -F --binary-files=without-match \
        --exclude-dir=build --exclude-dir=.dart_tool --exclude-dir=.git \
        -- "$base" "${SEARCH_DIRS[@]}" >/dev/null 2>&1; then
      continue
    fi
  fi

  printf "UNUSED? %s\n" "$rel"
  UNUSED_COUNT=$((UNUSED_COUNT+1))
done < <(/usr/bin/find "$SCAN_DIR" -type f -regex "$find_pattern" -print0)

printf "\nChecked %d assets. Potentially unused: %d\n" "$TOTAL" "$UNUSED_COUNT"

if [[ "$CI_MODE" == true && "$UNUSED_COUNT" -gt 0 ]]; then
  exit 3
fi
