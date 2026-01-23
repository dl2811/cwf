# Sync from Upstream AWF - UPGRADED VERSION
# Tự động resolve conflicts và convert paths

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     🔄 CWF - Smart Sync from Upstream AWF               ║" -ForegroundColor Cyan
Write-Host "║     (Auto-resolve conflicts + Convert paths)            ║" -ForegroundColor Cyan
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
Write-Host "📡 Bước 1: Fetching updates from upstream..." -ForegroundColor Cyan
git fetch upstream

# Check if there are any changes
$behindCommits = git rev-list --count HEAD..upstream/main 2>$null
if ($behindCommits -eq 0) {
    Write-Host "✅ Đã cập nhật! Không có thay đổi mới từ upstream." -ForegroundColor Green
    exit 0
}

Write-Host "   📦 Có $behindCommits commits mới từ upstream" -ForegroundColor Yellow
Write-Host ""

Write-Host "🔀 Bước 2: Merging với chiến lược 'theirs' (ưu tiên upstream)..." -ForegroundColor Cyan

# Strategy: Accept theirs (upstream) for content, then we'll fix paths
git merge upstream/main -X theirs --no-edit 2>&1 | Out-Null

if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️ Merge gặp vấn đề. Đang thử resolve thủ công..." -ForegroundColor Yellow
    
    # Get list of conflicted files
    $conflictedFiles = git diff --name-only --diff-filter=U
    
    if ($conflictedFiles) {
        Write-Host "   Đang accept theirs cho các file conflict..." -ForegroundColor Yellow
        foreach ($file in $conflictedFiles) {
            git checkout --theirs $file 2>$null
            git add $file 2>$null
        }
        git commit -m "Merge upstream (auto-resolved with theirs strategy)" 2>$null
    }
}

Write-Host "✅ Merge hoàn tất!" -ForegroundColor Green
Write-Host ""

Write-Host "🔧 Bước 3: Converting paths (Antigravity → Cursor)..." -ForegroundColor Cyan

# Define path replacements
$replacements = @(
    @{ From = 'Antigravity'; To = 'Cursor' },
    @{ From = '~/.gemini/antigravity/global_workflows/'; To = '~/.cursor/rules/cwf/' },
    @{ From = '~/.gemini/antigravity/schemas/'; To = '~/.cursor/schemas/' },
    @{ From = '~/.gemini/antigravity/templates/'; To = '~/.cursor/templates/' },
    @{ From = '~/.gemini/awf_version'; To = '~/.cursor/cwf_version' },
    @{ From = '~/.antigravity/'; To = '~/.cursor/' },
    @{ From = '.antigravity/'; To = '.cursor/' },
    @{ From = 'GEMINI.md'; To = 'cwf-global.mdc' },
    @{ From = '/awf-update'; To = '/cwf-update' },
    @{ From = 'AWF'; To = 'CWF' }
)

# Process all markdown files in workflows
$workflowFiles = Get-ChildItem -Path "workflows" -Filter "*.md" -ErrorAction SilentlyContinue
$fixedCount = 0

foreach ($file in $workflowFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    foreach ($r in $replacements) {
        $content = $content -replace [regex]::Escape($r.From), $r.To
    }
    
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "   ✅ Fixed: $($file.Name)" -ForegroundColor Green
        $fixedCount++
    }
}

# Also fix README.md in root if exists
if (Test-Path "README.md") {
    $content = Get-Content "README.md" -Raw -Encoding UTF8
    $originalContent = $content
    
    foreach ($r in $replacements) {
        $content = $content -replace [regex]::Escape($r.From), $r.To
    }
    
    if ($content -ne $originalContent) {
        Set-Content -Path "README.md" -Value $content -Encoding UTF8
        Write-Host "   ✅ Fixed: README.md" -ForegroundColor Green
        $fixedCount++
    }
}

Write-Host ""
if ($fixedCount -gt 0) {
    Write-Host "🔧 Đã sửa $fixedCount files" -ForegroundColor Yellow
    
    Write-Host ""
    Write-Host "📝 Bước 4: Committing changes..." -ForegroundColor Cyan
    git add .
    git commit -m "Sync from upstream AWF + auto-convert paths to Cursor"
    
    Write-Host ""
    Write-Host "🚀 Bước 5: Pushing to origin..." -ForegroundColor Cyan
    git push origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
        Write-Host "🎉 HOÀN TẤT! Đã sync và push thành công!" -ForegroundColor Green
        Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
    }
    else {
        Write-Host "⚠️ Push thất bại. Bạn cần push thủ công: git push origin main" -ForegroundColor Yellow
    }
}
else {
    Write-Host "✅ Không có file nào cần sửa paths (có thể đã đúng sẵn)" -ForegroundColor Green
    
    # Check if there are uncommitted changes
    $status = git status --porcelain
    if ($status) {
        Write-Host ""
        Write-Host "📝 Committing and pushing merge..." -ForegroundColor Cyan
        git add .
        git commit -m "Sync from upstream AWF"
        git push origin main
    }
    
    Write-Host ""
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
    Write-Host "🎉 HOÀN TẤT!" -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
}

Write-Host ""
