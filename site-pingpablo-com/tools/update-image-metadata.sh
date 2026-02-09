#!/bin/bash

# Check if exiftool is installed
if ! command -v exiftool &> /dev/null; then
    echo "Error: exiftool is not installed."
    echo "Please install it using:"
    echo "  macOS: brew install exiftool"
    echo "  Linux: sudo apt-get install libimage-exiftool-perl"
    exit 1
fi

# Check if image file is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <image-file>"
    exit 1
fi

IMAGE_FILE="$1"

# Check if file exists
if [ ! -f "$IMAGE_FILE" ]; then
    echo "Error: File '$IMAGE_FILE' not found."
    exit 1
fi

echo "=== CURRENT METADATA ==="
exiftool "$IMAGE_FILE"
echo ""

# Extract title from filename (remove path and extension)
FILENAME=$(basename "$IMAGE_FILE")
TITLE="${FILENAME%.*}"

# Get current timestamp
CURRENT_TIME=$(date "+%Y:%m:%d %H:%M:%S")

echo "=== PROPOSED CHANGES ==="
echo "The following metadata will be REMOVED (if present):"
echo "  - GPS coordinates"
echo "  - Camera/device information"
echo "  - Software details"
echo "  - Any personal identifiable information"
echo ""
echo "The following metadata will be SET:"
echo "  Title: $TITLE"
echo "  Author: pingpablo.com"
echo "  Artist: pingpablo.com"
echo "  Copyright: github.com/dsapab/pingpablo-com/blob/main/LICENSE"
echo "  Creation Time: $CURRENT_TIME"
echo "  Date/Time: $CURRENT_TIME"
echo ""

# Ask for description
read -p "Enter image description: " DESCRIPTION

if [ -z "$DESCRIPTION" ]; then
    echo "Error: Description cannot be empty."
    exit 1
fi

echo ""
echo "  Description: $DESCRIPTION"
echo "  Image Description: $DESCRIPTION"
echo ""

# Confirm before proceeding
read -p "Proceed with metadata update? (y/n): " CONFIRM

if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Operation cancelled."
    exit 0
fi

echo ""
echo "=== UPDATING METADATA ==="

# Remove all metadata first
exiftool -all= "$IMAGE_FILE" -overwrite_original

# Add new metadata
exiftool \
    -Title="$TITLE" \
    -Author="pingpablo.com" \
    -Description="$DESCRIPTION" \
    -Copyright="https://github.com/dsapab/pingpablo-com/blob/main/LICENSE" \
    -CreateDate="$CURRENT_TIME" \
    -Artist="pingpablo.com" \
    -ImageDescription="$DESCRIPTION" \
    -DateTime="$CURRENT_TIME" \
    -overwrite_original \
    "$IMAGE_FILE"

echo ""
echo "=== UPDATED METADATA ==="
exiftool "$IMAGE_FILE"
echo ""
echo "Metadata updated successfully!"
