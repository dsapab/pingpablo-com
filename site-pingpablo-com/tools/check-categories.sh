#!/bin/sh
# CC-BY-SA-4.0
# Category validation script

set -e

CATEGORIES_FILE="content/categories.txt"
BLOG_DIR="content/blog"
ERROR_FILE="/tmp/category_check_errors.$$"

# Extract valid categories (lines after VALID_CATEGORIES marker)
valid_categories=$(sed -n '/^# VALID_CATEGORIES/,$ p' "$CATEGORIES_FILE" | grep -v '^#' | grep -v '^$')

if [ -z "$valid_categories" ]; then
    echo "[ERROR] No valid categories found in $CATEGORIES_FILE"
    exit 1
fi

echo "Checking blog post categories..."

rm -f "$ERROR_FILE"
touch "$ERROR_FILE"

# Find all markdown files
find "$BLOG_DIR" -name "*.md" ! -name "*.sample" | while read -r file; do
    # Extract categories from frontmatter (between --- markers)
    in_frontmatter=0
    in_categories=0
    
    while IFS= read -r line; do
        case "$line" in
            "---")
                if [ $in_frontmatter -eq 0 ]; then
                    in_frontmatter=1
                else
                    break
                fi
                ;;
            "categories:")
                in_categories=1
                ;;
            "- "*)
                if [ $in_categories -eq 1 ]; then
                    category=$(echo "$line" | sed 's/^- //')
                    
                    # Check if category is valid
                    if ! echo "$valid_categories" | grep -Fxq "$category"; then
                        echo "[ERROR] Invalid category '$category' in $file"
                        echo "1" >> "$ERROR_FILE"
                    fi
                fi
                ;;
            *":"*)
                in_categories=0
                ;;
        esac
    done < "$file"
done

errors=$(wc -l < "$ERROR_FILE" | tr -d ' ')
rm -f "$ERROR_FILE"

if [ "$errors" -gt 0 ]; then
    echo "[ERROR] Found $errors invalid categories"
    exit 1
fi

echo "[OK] All categories are valid"
exit 0
