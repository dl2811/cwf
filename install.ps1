# CWF - Cursor Workflow Framework
# Cài đặt Global + Tạo script cwf-init để kích hoạt trong mỗi project

$RepoBase = "https://raw.githubusercontent.com/dl2811/cwf/main"
$RepoUrl = "$RepoBase/workflows"
$Workflows = @(
    "plan.md", "code.md", "visualize.md", "deploy.md",
    "debug.md", "refactor.md", "test.md", "run.md",
    "init.md", "recap.md", "rollback.md", "save_brain.md",
    "audit.md", "cloudflare-tunnel.md", "cwf-update.md",
    "brainstorm.md", "next.md", "customize.md"
)

# Schemas and Templates (v3.3+)
$Schemas = @(
    "brain.schema.json", "session.schema.json", "preferences.schema.json"
)
$Templates = @(
    "brain.example.json", "session.example.json", "preferences.example.json"
)

# Paths
$CwfGlobal = "$env:USERPROFILE\.cursor\cwf"
$SchemasDir = "$env:USERPROFILE\.cursor\cwf\schemas"
$TemplatesDir = "$env:USERPROFILE\.cursor\cwf\templates"
$WorkflowsDir = "$env:USERPROFILE\.cursor\cwf\workflows"
$CwfVersionFile = "$env:USERPROFILE\.cursor\cwf_version"

# Get version from repo
try {
    $CurrentVersion = (Invoke-WebRequest -Uri "$RepoBase/VERSION" -UseBasicParsing).Content.Trim()
}
catch {
    $CurrentVersion = "1.0.0"
}

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     🚀 CWF - Cursor Workflow Framework v$CurrentVersion          ║" -ForegroundColor Cyan
Write-Host "║     (Optimized for Cursor IDE)                          ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Check if updating
if (Test-Path $CwfVersionFile) {
    $OldVersion = Get-Content $CwfVersionFile
    Write-Host "📦 Phiên bản hiện tại: $OldVersion" -ForegroundColor Yellow
    Write-Host "📦 Phiên bản mới: $CurrentVersion" -ForegroundColor Green
    Write-Host ""
}

# 1. Create directories
Write-Host "📂 Bước 1: Tạo thư mục..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $CwfGlobal | Out-Null
New-Item -ItemType Directory -Force -Path $SchemasDir | Out-Null
New-Item -ItemType Directory -Force -Path $TemplatesDir | Out-Null
New-Item -ItemType Directory -Force -Path $WorkflowsDir | Out-Null
Write-Host "   ✅ Đã tạo: $CwfGlobal" -ForegroundColor Green

# 2. Download workflows
Write-Host ""
Write-Host "⏳ Bước 2: Đang tải workflows..." -ForegroundColor Cyan
$success = 0
foreach ($wf in $Workflows) {
    try {
        Invoke-WebRequest -Uri "$RepoUrl/$wf" -OutFile "$WorkflowsDir\$wf" -ErrorAction Stop
        Write-Host "   ✅ $wf" -ForegroundColor Green
        $success++
    }
    catch {
        Write-Host "   ❌ $wf" -ForegroundColor Red
    }
}

# 3. Download Schemas
Write-Host ""
Write-Host "⏳ Bước 3: Đang tải schemas..." -ForegroundColor Cyan
foreach ($schema in $Schemas) {
    try {
        Invoke-WebRequest -Uri "$RepoBase/schemas/$schema" -OutFile "$SchemasDir\$schema" -ErrorAction Stop
        Write-Host "   ✅ $schema" -ForegroundColor Green
        $success++
    }
    catch {
        Write-Host "   ❌ $schema" -ForegroundColor Red
    }
}

# 4. Download Templates
Write-Host ""
Write-Host "⏳ Bước 4: Đang tải templates..." -ForegroundColor Cyan
foreach ($template in $Templates) {
    try {
        Invoke-WebRequest -Uri "$RepoBase/templates/$template" -OutFile "$TemplatesDir\$template" -ErrorAction Stop
        Write-Host "   ✅ $template" -ForegroundColor Green
        $success++
    }
    catch {
        Write-Host "   ❌ $template" -ForegroundColor Red
    }
}

# 5. Save version
Set-Content -Path $CwfVersionFile -Value $CurrentVersion -Encoding UTF8
Write-Host ""
Write-Host "✅ Đã lưu version: $CurrentVersion" -ForegroundColor Green

# 6. Create cwf-init.ps1 script (for activating CWF in each project)
Write-Host ""
Write-Host "🔧 Bước 5: Tạo script cwf-init..." -ForegroundColor Cyan

$CwfInitScript = @'
# CWF Init - Kích hoạt CWF trong project hiện tại
# Chạy 1 lần trong mỗi project mới

$CwfGlobal = "$env:USERPROFILE\.cursor\cwf\workflows"
$ProjectRules = ".\.cursor\rules"

Write-Host ""
Write-Host "🚀 CWF Init - Kích hoạt workflows cho project này" -ForegroundColor Cyan
Write-Host ""

# Check if CWF is installed
if (-not (Test-Path $CwfGlobal)) {
    Write-Host "❌ CWF chưa được cài đặt. Chạy install.ps1 trước!" -ForegroundColor Red
    exit 1
}

# Create .cursor/rules folder
if (-not (Test-Path $ProjectRules)) {
    New-Item -ItemType Directory -Force -Path $ProjectRules | Out-Null
    Write-Host "📂 Đã tạo: $ProjectRules" -ForegroundColor Green
}

# Copy workflows to project
Write-Host "📝 Đang copy workflows..." -ForegroundColor Cyan
$copied = 0
Get-ChildItem -Path $CwfGlobal -Filter "*.md" | ForEach-Object {
    Copy-Item $_.FullName -Destination $ProjectRules -Force
    Write-Host "   ✅ $($_.Name)" -ForegroundColor Green
    $copied++
}

# Create main .cursorrules file with command mapping
$CursorRules = @"
# CWF - Cursor Workflow Framework

Bạn có quyền truy cập các workflows trong thư mục .cursor/rules/
Khi user gõ lệnh bắt đầu bằng /, hãy đọc file workflow tương ứng và thực hiện.

## Command Mapping:
| Lệnh | File |
|------|------|
| /brainstorm | @brainstorm.md |
| /plan | @plan.md |
| /code | @code.md |
| /visualize | @visualize.md |
| /debug | @debug.md |
| /test | @test.md |
| /run | @run.md |
| /deploy | @deploy.md |
| /init | @init.md |
| /recap | @recap.md |
| /next | @next.md |
| /save-brain | @save_brain.md |
| /audit | @audit.md |
| /refactor | @refactor.md |
| /rollback | @rollback.md |
| /customize | @customize.md |
| /cwf-update | @cwf-update.md |

## Cách thực hiện:
1. Khi user gõ /command, tìm file tương ứng trong .cursor/rules/
2. Đọc và thực hiện TỪNG BƯỚC trong workflow
3. Không bỏ qua bước nào
"@

Set-Content -Path ".\.cursorrules" -Value $CursorRules -Encoding UTF8
Write-Host ""
Write-Host "✅ Đã tạo .cursorrules" -ForegroundColor Green

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "🎉 HOÀN TẤT! Đã kích hoạt CWF cho project này." -ForegroundColor Yellow
Write-Host ""
Write-Host "📂 Workflows: $ProjectRules ($copied files)" -ForegroundColor DarkGray
Write-Host ""
Write-Host "👉 Restart Cursor và thử gõ: /plan hoặc /brainstorm" -ForegroundColor Cyan
Write-Host "👉 Hoặc dùng @ để reference: @plan.md" -ForegroundColor White
Write-Host ""
'@

Set-Content -Path "$CwfGlobal\cwf-init.ps1" -Value $CwfInitScript -Encoding UTF8
Write-Host "   ✅ cwf-init.ps1" -ForegroundColor Green

# 7. Add cwf-init to PATH or create alias
Write-Host ""
Write-Host "🔧 Bước 6: Tạo lệnh cwf-init..." -ForegroundColor Cyan

# Create a batch file wrapper for easy access
$CwfInitBat = @"
@echo off
powershell -ExecutionPolicy Bypass -File "%USERPROFILE%\.cursor\cwf\cwf-init.ps1" %*
"@
Set-Content -Path "$env:USERPROFILE\.cursor\cwf\cwf-init.bat" -Value $CwfInitBat -Encoding ASCII

# Add to PATH if not already there
$cwfPath = "$env:USERPROFILE\.cursor\cwf"
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$cwfPath*") {
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$cwfPath", "User")
    Write-Host "   ✅ Đã thêm vào PATH" -ForegroundColor Green
}
else {
    Write-Host "   ✅ Đã có trong PATH" -ForegroundColor Green
}

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "🎉 CÀI ĐẶT HOÀN TẤT!" -ForegroundColor Yellow
Write-Host "📦 Version: $CurrentVersion" -ForegroundColor Cyan
Write-Host ""
Write-Host "📂 CWF Global: $CwfGlobal" -ForegroundColor DarkGray
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host ""
Write-Host "👉 BƯỚC TIẾP THEO:" -ForegroundColor Cyan
Write-Host "   1. Mở CMD/PowerShell MỚI (để nhận PATH)" -ForegroundColor White
Write-Host "   2. cd vào project của bạn" -ForegroundColor White
Write-Host "   3. Chạy: cwf-init" -ForegroundColor Yellow
Write-Host "   4. Restart Cursor" -ForegroundColor White
Write-Host "   5. Dùng: /plan, /code, /brainstorm, ..." -ForegroundColor White
Write-Host ""

exit 0
