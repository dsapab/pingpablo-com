#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BLOG_DIR="$SCRIPT_DIR/../content/blog"
MEDIA_DIR="$SCRIPT_DIR/../assets/media/blog"
TEMPLATE="$BLOG_DIR/sample-post.md.sample"

read -p "Enter post name: " POST_NAME

if [[ -z "$POST_NAME" ]]; then
    echo "Error: Post name cannot be empty" >&2
    exit 1
fi

SLUG=$(echo "$POST_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//')
YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date +%d)
DATE=$(date +%Y-%m-%d)
TARGET_DIR="$BLOG_DIR/$YEAR/$MONTH"
FILENAME="${DAY}_${SLUG}.md"
MEDIA_TARGET_DIR="$MEDIA_DIR/$YEAR/$MONTH/${DAY}_${SLUG}"

mkdir -p "$TARGET_DIR" "$MEDIA_TARGET_DIR"

sed -e "s|date: <PLACEHOLDER>|date: $DATE|" \
    -e "s|linktitle: <PLACEHOLDER>|linktitle: $POST_NAME|" \
    -e "s|title: <PLACEHOLDER>|title: $POST_NAME|" \
    -e "s|cover: <PLACEHOLDER>/sample.jpeg|cover: /media/blog/$YEAR/$MONTH/${DAY}_${SLUG}/cover.jpeg|" \
    -e "s|- /blog/<PLACEHOLDER>|- /blog/$SLUG|" \
    "$TEMPLATE" > "$TARGET_DIR/$FILENAME"

echo "Created: $TARGET_DIR/$FILENAME"
echo "Media directory: $MEDIA_TARGET_DIR"
