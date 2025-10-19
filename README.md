# sailing_chefs

A new Flutter project.

## Asset optimization (images and SVGs)

This repo includes a macOS-friendly script to reduce app size and speed up installs/startup by compressing large assets under `assets/images`.

Why: We have several heavy assets (for example, `assets/images/background/backk.svg` is ~20MB and many PNGs are 500–2,500KB). Optimizing these will reduce app size significantly.

What it does:

- Losslessly compress PNG/JPG in place using `pngquant`, `oxipng`, and ImageMagick
- Optionally create `.webp` copies for further savings
- Optimize SVGs with `svgo` and warn on embedded raster images

Install prerequisites (one-time):

```sh
brew install webp pngquant oxipng imagemagick
npm i -g svgo
# optional (extra svg cleanup)
pip3 install scour
```

Dry-run (safe default):

```sh
chmod +x tools/optimize_assets.sh
tools/optimize_assets.sh
```

Apply changes (in-place optimization):

```sh
tools/optimize_assets.sh --apply
```

Create WebP copies alongside originals:

```sh
tools/optimize_assets.sh --webp-copies --apply
```

Adjust target directory/threshold:

```sh
tools/optimize_assets.sh --dir assets --threshold 300k --apply
```

Notes and tips:

- Very large or complex SVGs (like `backk.svg`) may contain unnecessary points or embedded rasters; consider exporting simpler vectors or using a compressed WebP/PNG instead.
- For full adoption of WebP, update `pubspec.yaml` and references to point to `.webp` files. Flutter supports WebP on iOS/Android.
- Background images rarely need 4K resolutions; resize to your max target device size (e.g., 1080–1440px wide) before compression for the best savings.
- After changes, run your build task to ensure assets are still included correctly.

### Detect potentially unused assets

Use the helper to spot assets under `assets/` that aren’t referenced in code or pubspec:

```sh
chmod +x tools/find_unused_assets.sh
tools/find_unused_assets.sh                 # prints lines like: UNUSED? assets/images/icons/old.png
tools/find_unused_assets.sh --basename-fallback  # broader search if you build paths dynamically
```

Make it fail CI if unused assets are detected:

```sh
tools/find_unused_assets.sh --ci
```

Whitelist known false positives by adding paths to `.asset-whitelist.txt` (repo root), one per line.
