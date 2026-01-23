# Sync from Upstream AWF
# Run this script to pull updates from the original AWF repo

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     🔄 CWF - Sync from Upstream AWF                      ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Check if we're in a git repo
if (-not (Test-Path ".git")) {
    Write-Host "❌ Không tìm thấy git repo. Hãy chạy script này trong thư mục cwf." -ForegroundColor Red
    exit 1
}

# Check if upstream is configured
$upstream = git remote get-url upstream 2>$null
if (-not $upstream) {
    Write-Host "⏳ Đang thêm upstream remote..." -ForegroundColor Yellow
    git remote add upstream https://github.com/TUAN130294/awf.git
    Write-Host "✅ Đã thêm upstream: https://github.com/TUAN130294/awf.git" -ForegroundColor Green
}

Write-Host ""
Write-Host "📡 Fetching updates from upstream..." -ForegroundColor Cyan
git fetch upstream

Write-Host ""
Write-Host "🔀 Merging upstream/main into current branch..." -ForegroundColor Cyan
Write-Host ""

# Try to merge - don't commit automatically so user can review
$mergeResult = git merge upstream/main --no-commit --no-ff 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Merge thành công! Không có conflicts." -ForegroundColor Green
    Write-Host ""
    Write-Host "📝 Các thay đổi đã được merge nhưng CHƯA COMMIT." -ForegroundColor Yellow
    Write-Host "   Bạn cần review và commit thủ công:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "   1. Kiểm tra thay đổi: git status" -ForegroundColor White
    Write-Host "   2. Xem diff: git diff --staged" -ForegroundColor White
    Write-Host "   3. Commit: git commit -m 'Sync from upstream AWF'" -ForegroundColor White
    Write-Host "   4. Push: git push origin main" -ForegroundColor White
}
else {
    Write-Host "⚠️ Có CONFLICTS cần resolve!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "📝 Các file bị conflict (thường là do path đã đổi):" -ForegroundColor Yellow
    git diff --name-only --diff-filter=U
    Write-Host ""
    Write-Host "👉 Cách xử lý:" -ForegroundColor Cyan
    Write-Host "   1. Mở các file conflict và chọn phiên bản phù hợp" -ForegroundColor White
    Write-Host "   2. Giữ paths của Cursor (~/.cursor/), lấy logic mới từ upstream" -ForegroundColor White
    Write-Host "   3. Sau khi sửa xong: git add ." -ForegroundColor White
    Write-Host "   4. Commit: git commit -m 'Sync from upstream AWF (resolved conflicts)'" -ForegroundColor White
    Write-Host "   5. Push: git push origin main" -ForegroundColor White
}

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host ""
