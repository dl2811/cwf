# Sync from Upstream AWF - UPGRADED VERSION
# Auto resolve conflicts and convert paths

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "     CWF - Smart Sync from Upstream AWF" -ForegroundColor Cyan
Write-Host "     (Auto-resolve conflicts + Convert paths)" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Check if we're in a git repo
if (-not (Test-Path ".git")) {
    Write-Host "[ERROR] Not a git repo. Run this script in cwf folder." -ForegroundColor Red
    exit 1
}

# Check if upstream is configured
$upstream = git remote get-url upstream 2>$null
if (-not $upstream) {
    Write-Host "[INFO] Adding upstream remote..." -ForegroundColor Yellow
    git remote add upstream https://github.com/TUAN130294/awf.git
    Write-Host "[OK] Added upstream: https://github.com/TUAN130294/awf.git" -ForegroundColor Green
}

Write-Host ""
Write-Host "[Step 1] Fetching updates from upstream..." -ForegroundColor Cyan
git fetch upstream

# Check if there are any changes
$behindCommits = git rev-list --count HEAD..upstream/main 2>$null
if ($behindCommits -eq 0) {
    Write-Host "[OK] Already up to date! No new changes from upstream." -ForegroundColor Green
    exit 0
}

Write-Host "   Found $behindCommits new commits from upstream" -ForegroundColor Yellow
Write-Host ""

Write-Host "[Step 2] Merging with 'theirs' strategy (prefer upstream)..." -ForegroundColor Cyan

# Strategy: Accept theirs (upstream) for content, then we'll fix paths
git merge upstream/main -X theirs --no-edit 2>&1 | Out-Null

if ($LASTEXITCODE -ne 0) {
    Write-Host "[WARN] Merge had issues. Trying manual resolve..." -ForegroundColor Yellow
    
    # Get list of conflicted files
    $conflictedFiles = git diff --name-only --diff-filter=U
    
    if ($conflictedFiles) {
        Write-Host "   Accepting theirs for conflicted files..." -ForegroundColor Yellow
        foreach ($file in $conflictedFiles) {
            git checkout --theirs $file 2>$null
            git add $file 2>$null
        }
        git commit -m "Merge upstream (auto-resolved with theirs strategy)" 2>$null
    }
}

Write-Host "[OK] Merge complete!" -ForegroundColor Green
Write-Host ""

Write-Host "[Step 3] Converting paths (Antigravity -> Cursor)..." -ForegroundColor Cyan

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
        Write-Host "   [OK] Fixed: $($file.Name)" -ForegroundColor Green
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
        Write-Host "   [OK] Fixed: README.md" -ForegroundColor Green
        $fixedCount++
    }
}

Write-Host ""
if ($fixedCount -gt 0) {
    Write-Host "[INFO] Fixed $fixedCount files" -ForegroundColor Yellow
    
    Write-Host ""
    Write-Host "[Step 4] Committing changes..." -ForegroundColor Cyan
    git add .
    git commit -m "Sync from upstream AWF + auto-convert paths to Cursor"
    
    Write-Host ""
    Write-Host "[Step 5] Pushing to origin..." -ForegroundColor Cyan
    git push origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "============================================================" -ForegroundColor DarkGray
        Write-Host "[SUCCESS] Sync and push completed!" -ForegroundColor Green
        Write-Host "============================================================" -ForegroundColor DarkGray
    }
    else {
        Write-Host "[WARN] Push failed. Push manually: git push origin main" -ForegroundColor Yellow
    }
}
else {
    Write-Host "[OK] No files need path fixes (already correct)" -ForegroundColor Green
    
    # Check if there are uncommitted changes
    $status = git status --porcelain
    if ($status) {
        Write-Host ""
        Write-Host "[Step 4] Committing and pushing merge..." -ForegroundColor Cyan
        git add .
        git commit -m "Sync from upstream AWF"
        git push origin main
    }
    
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor DarkGray
    Write-Host "[SUCCESS] Done!" -ForegroundColor Green
    Write-Host "============================================================" -ForegroundColor DarkGray
}

Write-Host ""
