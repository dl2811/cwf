#!/bin/bash
# Sync from Upstream AWF - UPGRADED VERSION
# Tự động resolve conflicts và convert paths

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║     🔄 CWF - Smart Sync from Upstream AWF               ║"
echo "║     (Auto-resolve conflicts + Convert paths)            ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# Check if we're in a git repo
if [ ! -d ".git" ]; then
    echo "❌ Không tìm thấy git repo. Hãy chạy script này trong thư mục cwf."
    exit 1
fi

# Check if upstream is configured
if ! git remote get-url upstream &>/dev/null; then
    echo "⏳ Đang thêm upstream remote..."
    git remote add upstream https://github.com/TUAN130294/awf.git
    echo "✅ Đã thêm upstream: https://github.com/TUAN130294/awf.git"
fi

echo ""
echo "📡 Bước 1: Fetching updates from upstream..."
git fetch upstream

# Check if there are any changes
BEHIND_COMMITS=$(git rev-list --count HEAD..upstream/main 2>/dev/null || echo "0")
if [ "$BEHIND_COMMITS" -eq 0 ]; then
    echo "✅ Đã cập nhật! Không có thay đổi mới từ upstream."
    exit 0
fi

echo "   📦 Có $BEHIND_COMMITS commits mới từ upstream"
echo ""

echo "🔀 Bước 2: Merging với chiến lược 'theirs' (ưu tiên upstream)..."

# Strategy: Accept theirs (upstream) for content, then we'll fix paths
if ! git merge upstream/main -X theirs --no-edit 2>/dev/null; then
    echo "⚠️ Merge gặp vấn đề. Đang thử resolve thủ công..."
    
    # Get list of conflicted files and accept theirs
    CONFLICTED=$(git diff --name-only --diff-filter=U)
    if [ -n "$CONFLICTED" ]; then
        echo "   Đang accept theirs cho các file conflict..."
        for file in $CONFLICTED; do
            git checkout --theirs "$file" 2>/dev/null
            git add "$file" 2>/dev/null
        done
        git commit -m "Merge upstream (auto-resolved with theirs strategy)" 2>/dev/null
    fi
fi

echo "✅ Merge hoàn tất!"
echo ""

echo "🔧 Bước 3: Converting paths (Antigravity → Cursor)..."

FIXED_COUNT=0

# Function to fix paths in a file
fix_paths() {
    local file="$1"
    if [ -f "$file" ]; then
        local original=$(cat "$file")
        local content="$original"
        
        # Apply replacements
        content=$(echo "$content" | sed 's/Antigravity/Cursor/g')
        content=$(echo "$content" | sed 's|~/.gemini/antigravity/global_workflows/|~/.cursor/rules/cwf/|g')
        content=$(echo "$content" | sed 's|~/.gemini/antigravity/schemas/|~/.cursor/schemas/|g')
        content=$(echo "$content" | sed 's|~/.gemini/antigravity/templates/|~/.cursor/templates/|g')
        content=$(echo "$content" | sed 's|~/.gemini/awf_version|~/.cursor/cwf_version|g')
        content=$(echo "$content" | sed 's|~/.antigravity/|~/.cursor/|g')
        content=$(echo "$content" | sed 's|.antigravity/|.cursor/|g')
        content=$(echo "$content" | sed 's/GEMINI.md/cwf-global.mdc/g')
        content=$(echo "$content" | sed 's|/awf-update|/cwf-update|g')
        content=$(echo "$content" | sed 's/AWF/CWF/g')
        
        if [ "$content" != "$original" ]; then
            echo "$content" > "$file"
            echo "   ✅ Fixed: $(basename $file)"
            FIXED_COUNT=$((FIXED_COUNT + 1))
        fi
    fi
}

# Process all markdown files in workflows
for file in workflows/*.md; do
    fix_paths "$file"
done

# Also fix README.md in root
fix_paths "README.md"

echo ""
if [ $FIXED_COUNT -gt 0 ]; then
    echo "🔧 Đã sửa $FIXED_COUNT files"
    
    echo ""
    echo "📝 Bước 4: Committing changes..."
    git add .
    git commit -m "Sync from upstream AWF + auto-convert paths to Cursor"
    
    echo ""
    echo "🚀 Bước 5: Pushing to origin..."
    if git push origin main; then
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "🎉 HOÀN TẤT! Đã sync và push thành công!"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    else
        echo "⚠️ Push thất bại. Bạn cần push thủ công: git push origin main"
    fi
else
    echo "✅ Không có file nào cần sửa paths (có thể đã đúng sẵn)"
    
    # Check if there are uncommitted changes
    if [ -n "$(git status --porcelain)" ]; then
        echo ""
        echo "📝 Committing and pushing merge..."
        git add .
        git commit -m "Sync from upstream AWF"
        git push origin main
    fi
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🎉 HOÀN TẤT!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi

echo ""
