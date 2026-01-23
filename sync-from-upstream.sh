#!/bin/bash
# Sync from Upstream AWF
# Run this script to pull updates from the original AWF repo

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║     🔄 CWF - Sync from Upstream AWF                      ║"
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
echo "📡 Fetching updates from upstream..."
git fetch upstream

echo ""
echo "🔀 Merging upstream/main into current branch..."
echo ""

# Try to merge - don't commit automatically so user can review
if git merge upstream/main --no-commit --no-ff 2>&1; then
    echo "✅ Merge thành công! Không có conflicts."
    echo ""
    echo "📝 Các thay đổi đã được merge nhưng CHƯA COMMIT."
    echo "   Bạn cần review và commit thủ công:"
    echo ""
    echo "   1. Kiểm tra thay đổi: git status"
    echo "   2. Xem diff: git diff --staged"
    echo "   3. Commit: git commit -m 'Sync from upstream AWF'"
    echo "   4. Push: git push origin main"
else
    echo "⚠️ Có CONFLICTS cần resolve!"
    echo ""
    echo "📝 Các file bị conflict (thường là do path đã đổi):"
    git diff --name-only --diff-filter=U
    echo ""
    echo "👉 Cách xử lý:"
    echo "   1. Mở các file conflict và chọn phiên bản phù hợp"
    echo "   2. Giữ paths của Cursor (~/.cursor/), lấy logic mới từ upstream"
    echo "   3. Sau khi sửa xong: git add ."
    echo "   4. Commit: git commit -m 'Sync from upstream AWF (resolved conflicts)'"
    echo "   5. Push: git push origin main"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
