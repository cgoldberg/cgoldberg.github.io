---
title: Bash - Convert and consolidate photos
description: Convert files to JPEG and consolidate them into one directory
date: 2026-08-30
tags: [bash, linux]
---

A Bash script that recursively scans and consolidates photos into a single
directory, converting HEIC/HEIF and LIVP files to JPEG, normalizing file
extensions, preserving originals, and avoiding filename conflicts:

```bash
#!/usr/bin/env bash
#
# Corey Goldberg 2026 (https://github.com/cgoldberg)
#
# Recursively convert and consolidate photos
#
# Requires:
#   ImageMagick, binwalk
#
# Converts:
#   .jpg / .JPG / .jpeg / .JPEG  -> copied unchanged
#   .heif / .HEIF / .heic / .HEIC -> converted to JPEG, quality 100
#   .livp -> extracts embedded JPEG, quality 100
#
# All output goes into one directory.
# File extensions are normalized to `.jpg`.
# Duplicate filenames become _1, _2, etc.
#
# SOURCE FILES ARE NEVER DELETED, MOVED, OR MODIFIED.
#
# Usage:
#   ./flatten-jpegs.sh SOURCE_DIR OUTPUT_DIR
#
# Example:
#   ./flatten-jpegs.sh /mnt/photos /mnt/photos-flat

set -u

SOURCE="${1:-}"
OUTPUT="${2:-}"

if [[ -z "$SOURCE" || -z "$OUTPUT" ]]; then
    echo "Usage: $0 SOURCE_DIR OUTPUT_DIR"
    exit 1
fi

if [[ ! -d "$SOURCE" ]]; then
    echo "ERROR: source directory does not exist: $SOURCE"
    exit 1
fi

mkdir -p -- "$OUTPUT" || exit 1

# Generate a unique output filename.
unique_name() {
    local base="$1"
    local candidate="${base}.jpg"
    local n=1
    while [[ -e "$OUTPUT/$candidate" ]]; do
        candidate="${base}_${n}.jpg"
        ((n++))
    done
    printf '%s\n' "$candidate"
}

copied=0
converted=0
livp=0
failed=0
skipped=0

while IFS= read -r -d '' file; do
    filename="$(basename "$file")"
    ext="${filename##*.}"
    ext="${ext,,}"
    # Remove extension from original filename.
    base="${filename%.*}"

    case "$ext" in

        jpg|jpeg)
            # Existing JPEG: copy without recompression.
            output_name="$(unique_name "$base")"
            if cp -- "$file" "$OUTPUT/$output_name"; then
                echo "COPY     $file"
                echo "      -> $output_name"
                ((copied++))
            else
                echo "ERROR    $file"
                ((failed++))
            fi
            ;;

        heif|heic)
            # HEIF/HEIC -> JPEG at maximum JPEG quality.
            output_name="$(unique_name "$base")"
            if magick "$file" -quality 100 \
                "$OUTPUT/$output_name" 2>/dev/null; then
                echo "CONVERT  $file"
                echo "      -> $output_name"
                ((converted++))
            else
                echo "ERROR    $file"
                rm -f -- "$OUTPUT/$output_name"
                ((failed++))
            fi
            ;;

        livp)
            # LIVP files contain the JPEG beginning at byte 6.
            # tail -c +7 starts at byte 6 (1-based).
            # ImageMagick reads the embedded JPEG and writes a
            # clean JPEG at quality 100.
            output_name="$(unique_name "$base")"
            if tail -c +7 -- "$file" |
                magick - -quality 100 "$OUTPUT/$output_name" 2>/dev/null; then
                echo "LIVP     $file"
                echo "      -> $output_name"
                ((livp++))
            else
                echo "ERROR    $file"
                rm -f -- "$OUTPUT/$output_name"
                ((failed++))
            fi
            ;;

        *)
            ((skipped++))
            ;;

    esac

done < <(find "$SOURCE" -type f -print0)

echo
echo "========================================"
echo "Finished"
echo "========================================"
echo "JPEG copied : $copied"
echo "HEIF/HEIC   : $converted"
echo "LIVP        : $livp"
echo "Failed      : $failed"
echo "Skipped     : $skipped"
echo "----------------------------------------"
echo "Output      : $OUTPUT"
echo "========================================"
```
{: file='flatten-jpegs.sh'}
