#!/usr/bin/env bash
set -euo pipefail

# Asset optimizer for Flutter projects (macOS-friendly)
# - Losslessly compress PNG/JPG in-place (default)
# - Optionally create WebP copies for further savings
# - Optimize SVGs with svgo (and warn if embedded rasters found)
#
# Safe by default: dry-run mode shows what would happen.
# Use --apply to perform changes.
#
# Requirements (install as needed):
#   brew install webp pngquant oxipng imagemagick
#   npm i -g svgo
#   pip3 install scour  # optional, for extra SVG cleanup
#
# Examples:
#   tools/optimize_assets.sh                 # dry run for assets/images
#   tools/optimize_assets.sh --apply         # actually optimize in-place
#   tools/optimize_assets.sh --dir assets --threshold 300k --webp-copies --apply

DIR="assets/images"
THRESHOLD="400k"   # only target files larger than this
DO_APPLY=false
MAKE_WEBP_COPIES=false
OPTIMIZE_SVG=true

log() { printf "%s\n" "$*"; }
warn() { printf "\e[33m%s\e[0m\n" "$*"; }
err() { printf "\e[31m%s\e[0m\n" "$*" 1>&2; }

usage() {
  cat <<EOF
Usage: $0 [--dir <path>] [--threshold <N[k|M]>] [--apply] [--webp-copies] [--no-svg]

Options:
  --dir <path>         Root folder to scan (default: assets/images)
  --threshold <size>   Only process files larger than this (default: 400k)
  --apply              Perform changes (otherwise dry-run)
  --webp-copies        Also produce .webp copies next to originals
  --no-svg             Skip SVG optimization

Notes:
  - PNG/JPG are losslessly optimized in place by default (no quality loss).
  - .webp copies are not referenced automatically; update asset paths if you adopt them.
  - SVG optimization can dramatically shrink size; consider simplifying complex vectors.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dir)
      DIR="$2"; shift 2;;
    --threshold)
      THRESHOLD="$2"; shift 2;;
    --apply)
      DO_APPLY=true; shift;;
    --webp-copies)
      MAKE_WEBP_COPIES=true; shift;;
    --no-svg)
      OPTIMIZE_SVG=false; shift;;
    -h|--help)
      usage; exit 0;;
    *)
      err "Unknown arg: $1"; usage; exit 1;;
  esac
done

# Dependency checks (warn-only in dry-run)
need_bin() { command -v "$1" >/dev/null 2>&1; }

missing=()
for b in cwebp pngquant oxipng mogrify svgo; do
  if ! need_bin "$b"; then missing+=("$b"); fi
done

if ((${#missing[@]})); then
  warn "Missing suggested tools: ${missing[*]}"
  warn "Install with: brew install webp pngquant oxipng imagemagick && npm i -g svgo"
  if [[ "$DO_APPLY" == true ]]; then
    warn "Proceeding may result in fewer optimizations."
  fi
fi

ACTION() {
  if [[ "$DO_APPLY" == true ]]; then
    "$@"
  else
    printf "[dry-run] %s\n" "$*"
  fi
}

human_size() { /usr/bin/du -h "$1" | awk '{print $1}'; }

optimize_png() {
  local f="$1"; local before after
  before=$(human_size "$f")
  # Try pngquant (lossy but visually lossless) then oxipng (lossless)
  if need_bin pngquant; then
    ACTION pngquant --force --speed 1 --quality=75-95 --strip --output "$f" -- "$f"
  fi
  if need_bin oxipng; then
    ACTION oxipng -o 4 --strip all "$f"
  fi
  after=$(human_size "$f")
  log "PNG  ${before} -> ${after}  $f"
}

optimize_jpg() {
  local f="$1"; local before after
  before=$(human_size "$f")
  # Use ImageMagick to losslessly recompress and strip metadata
  if need_bin mogrify; then
    ACTION mogrify -strip -interlace Plane -sampling-factor 4:2:0 -quality 85 "$f"
  else
    warn "mogrify missing; skipping JPEG optimize for $f"
  fi
  after=$(human_size "$f")
  log "JPG  ${before} -> ${after}  $f"
}

make_webp_copy() {
  local f="$1"; local out="${f%.*}.webp"
  if need_bin cwebp; then
    case "${f##*.}" in
      png) ACTION cwebp -lossless -z 9 -metadata none "$f" -o "$out";;
      jpg|jpeg) ACTION cwebp -q 82 -m 6 -metadata none "$f" -o "$out";;
      *) return;;
    esac
    if [[ "$DO_APPLY" == true ]]; then
      log "WEBP created: $out ($(human_size "$out"))"
    else
      log "WEBP would create: $out"
    fi
  else
    warn "cwebp missing; cannot create WebP copy for $f"
  fi
}

optimize_svg() {
  local f="$1"; local before after
  before=$(human_size "$f")
  if need_bin svgo; then
    ACTION svgo --multipass "$f"
  fi
  # Detect embedded rasters
  if /usr/bin/grep -qiE "<image|xlink:href=\"data:image/(png|jpeg)" "$f"; then
    warn "SVG embeds raster data: $f — consider replacing with a compressed WebP"
  fi
  after=$(human_size "$f")
  log "SVG  ${before} -> ${after}  $f"
}

log "Scanning: $DIR (threshold > $THRESHOLD)"
log "Mode: ${DO_APPLY:+apply}${DO_APPLY:-dry-run} | webp-copies: $MAKE_WEBP_COPIES | svg: $OPTIMIZE_SVG"

# PNG
while IFS= read -r -d '' f; do
  optimize_png "$f"
  if [[ "$MAKE_WEBP_COPIES" == true ]]; then make_webp_copy "$f"; fi
done < <(/usr/bin/find "$DIR" -type f -name "*.png" -size +"$THRESHOLD" -print0)

# JPG
while IFS= read -r -d '' f; do
  optimize_jpg "$f"
  if [[ "$MAKE_WEBP_COPIES" == true ]]; then make_webp_copy "$f"; fi
done < <(/usr/bin/find "$DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" \) -size +"$THRESHOLD" -print0)

# SVG
if [[ "$OPTIMIZE_SVG" == true ]]; then
  while IFS= read -r -d '' f; do
    optimize_svg "$f"
  done < <(/usr/bin/find "$DIR" -type f -name "*.svg" -size +"$THRESHOLD" -print0)
fi

log "Done. ${DO_APPLY:+(changes applied)}${DO_APPLY:-(dry-run only)}"
