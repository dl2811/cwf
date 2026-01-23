# CWF - Cursor Workflow Framework (Fork of AWF)
# Converted for Cursor IDE compatibility
# Original: https://github.com/TUAN130294/awf

$RepoBase = "https://raw.githubusercontent.com/dl2811/cwf/main"
$RepoUrl = "$RepoBase/workflows"
$Workflows = @(
    "plan.md", "code.md", "visualize.md", "deploy.md",
    "debug.md", "refactor.md", "test.md", "run.md",
    "init.md", "recap.md", "rollback.md", "save_brain.md",
    "audit.md", "cloudflare-tunnel.md", "cwf-update.md",
    "brainstorm.md", "next.md", "customize.md", "README.md"
)

# Schemas and Templates (v3.3+)
$Schemas = @(
    "brain.schema.json", "session.schema.json", "preferences.schema.json"
)
$Templates = @(
    "brain.example.json", "session.example.json", "preferences.example.json"
)

# Detect Cursor Global Path
$CursorGlobal = "$env:USERPROFILE\.cursor\rules\cwf"
$SchemasDir = "$env:USERPROFILE\.cursor\schemas"
$TemplatesDir = "$env:USERPROFILE\.cursor\templates"
$CursorRulesDir = "$env:USERPROFILE\.cursor\rules"
$CwfVersionFile = "$env:USERPROFILE\.cursor\cwf_version"

# Get version from repo
try {
    $CurrentVersion = (Invoke-WebRequest -Uri "$RepoBase/VERSION" -UseBasicParsing).Content.Trim()
} catch {
    $CurrentVersion = "1.0.0"
}

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     🚀 CWF - Cursor Workflow Framework v$CurrentVersion          ║" -ForegroundColor Cyan
Write-Host "║     (Fork of AWF for Cursor IDE)                         ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Check if updating
if (Test-Path $CwfVersionFile) {
    $OldVersion = Get-Content $CwfVersionFile
    Write-Host "📦 Phiên bản hiện tại: $OldVersion" -ForegroundColor Yellow
    Write-Host "📦 Phiên bản mới: $CurrentVersion" -ForegroundColor Green
    Write-Host ""
}

# 1. Cài Global Workflows
if (-not (Test-Path $CursorGlobal)) {
    New-Item -ItemType Directory -Force -Path $CursorGlobal | Out-Null
    Write-Host "📂 Đã tạo thư mục Global: $CursorGlobal" -ForegroundColor Green
} else {
    Write-Host "✅ Tìm thấy Cursor Global: $CursorGlobal" -ForegroundColor Green
}

Write-Host "⏳ Đang tải workflows..." -ForegroundColor Cyan
$success = 0
foreach ($wf in $Workflows) {
    try {
        Invoke-WebRequest -Uri "$RepoUrl/$wf" -OutFile "$CursorGlobal\$wf" -ErrorAction Stop
        Write-Host "   ✅ $wf" -ForegroundColor Green
        $success++
    } catch {
        Write-Host "   ❌ $wf" -ForegroundColor Red
    }
}

# 2. Download Schemas (v3.3+)
if (-not (Test-Path $SchemasDir)) {
    New-Item -ItemType Directory -Force -Path $SchemasDir | Out-Null
}
Write-Host "⏳ Đang tải schemas..." -ForegroundColor Cyan
foreach ($schema in $Schemas) {
    try {
        Invoke-WebRequest -Uri "$RepoBase/schemas/$schema" -OutFile "$SchemasDir\$schema" -ErrorAction Stop
        Write-Host "   ✅ $schema" -ForegroundColor Green
        $success++
    } catch {
        Write-Host "   ❌ $schema" -ForegroundColor Red
    }
}

# 3. Download Templates (v3.3+)
if (-not (Test-Path $TemplatesDir)) {
    New-Item -ItemType Directory -Force -Path $TemplatesDir | Out-Null
}
Write-Host "⏳ Đang tải templates..." -ForegroundColor Cyan
foreach ($template in $Templates) {
    try {
        Invoke-WebRequest -Uri "$RepoBase/templates/$template" -OutFile "$TemplatesDir\$template" -ErrorAction Stop
        Write-Host "   ✅ $template" -ForegroundColor Green
        $success++
    } catch {
        Write-Host "   ❌ $template" -ForegroundColor Red
    }
}

# 4. Save version
if (-not (Test-Path "$env:USERPROFILE\.cursor")) {
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.cursor" | Out-Null
}
Set-Content -Path $CwfVersionFile -Value $CurrentVersion -Encoding UTF8
Write-Host "✅ Đã lưu version: $CurrentVersion" -ForegroundColor Green

# 5. Create Global Rules file (.mdc format for Cursor)
$CwfInstructions = @"
---
description: CWF - Cursor Workflow Framework
globs: 
alwaysApply: true
---

# CWF - Cursor Workflow Framework

## CRITICAL: Command Recognition
Khi user gõ các lệnh bắt đầu bằng ``/`` dưới đây, đây là CWF WORKFLOW COMMANDS (không phải file path).
Bạn PHẢI đọc file workflow tương ứng và thực hiện theo hướng dẫn trong đó.

## Command Mapping (QUAN TRỌNG):
| Command | Workflow File | Mô tả |
|---------|--------------|-------|
| ``/brainstorm`` | ~/.cursor/rules/cwf/brainstorm.md | 💡 Bàn ý tưởng, research thị trường |
| ``/plan`` | ~/.cursor/rules/cwf/plan.md | Thiết kế tính năng |
| ``/code`` | ~/.cursor/rules/cwf/code.md | Viết code an toàn |
| ``/visualize`` | ~/.cursor/rules/cwf/visualize.md | Tạo UI/UX |
| ``/debug`` | ~/.cursor/rules/cwf/debug.md | Sửa lỗi sâu |
| ``/test`` | ~/.cursor/rules/cwf/test.md | Kiểm thử |
| ``/run`` | ~/.cursor/rules/cwf/run.md | Chạy ứng dụng |
| ``/deploy`` | ~/.cursor/rules/cwf/deploy.md | Deploy production |
| ``/init`` | ~/.cursor/rules/cwf/init.md | Khởi tạo dự án |
| ``/recap`` | ~/.cursor/rules/cwf/recap.md | Khôi phục ngữ cảnh |
| ``/next`` | ~/.cursor/rules/cwf/next.md | Gợi ý bước tiếp theo |
| ``/customize`` | ~/.cursor/rules/cwf/customize.md | ⚙️ Cá nhân hóa AI |
| ``/save-brain`` | ~/.cursor/rules/cwf/save_brain.md | Lưu kiến thức |
| ``/audit`` | ~/.cursor/rules/cwf/audit.md | Kiểm tra bảo mật |
| ``/refactor`` | ~/.cursor/rules/cwf/refactor.md | Tái cấu trúc code |
| ``/rollback`` | ~/.cursor/rules/cwf/rollback.md | Rollback deployment |
| ``/cloudflare-tunnel`` | ~/.cursor/rules/cwf/cloudflare-tunnel.md | Quản lý tunnel |
| ``/cwf-update`` | ~/.cursor/rules/cwf/cwf-update.md | Cập nhật CWF |

## Resource Locations (v3.3+):
- Schemas: ~/.cursor/schemas/
- Templates: ~/.cursor/templates/

## Hướng dẫn thực hiện:
1. Khi user gõ một trong các commands trên, ĐỌC FILE WORKFLOW tương ứng
2. Thực hiện TỪNG GIAI ĐOẠN trong workflow
3. KHÔNG tự ý bỏ qua bước nào
4. Kết thúc bằng NEXT STEPS menu như trong workflow

## Update Check:
- CWF version được lưu tại: ~/.cursor/cwf_version
- Để kiểm tra và cập nhật CWF, user gõ: /cwf-update
- Thỉnh thoảng (1 lần/tuần) nhắc user kiểm tra update nếu họ dùng CWF thường xuyên
"@

$CwfRulesFile = "$CursorRulesDir\cwf-global.mdc"
if (-not (Test-Path $CursorRulesDir)) {
    New-Item -ItemType Directory -Force -Path $CursorRulesDir | Out-Null
}
Set-Content -Path $CwfRulesFile -Value $CwfInstructions -Encoding UTF8
Write-Host "✅ Đã tạo Global Rules (cwf-global.mdc)" -ForegroundColor Green

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "🎉 HOÀN TẤT! Đã cài $success files vào hệ thống." -ForegroundColor Yellow
Write-Host "📦 Version: $CurrentVersion" -ForegroundColor Cyan
Write-Host ""
Write-Host "📂 Workflows: $CursorGlobal" -ForegroundColor DarkGray
Write-Host "📂 Schemas:   $SchemasDir" -ForegroundColor DarkGray
Write-Host "📂 Templates: $TemplatesDir" -ForegroundColor DarkGray
Write-Host "📂 Rules:     $CwfRulesFile" -ForegroundColor DarkGray
Write-Host ""
Write-Host "👉 Bạn có thể dùng CWF ở BẤT KỲ project nào ngay lập tức!" -ForegroundColor Cyan
Write-Host "👉 Thử gõ '/plan' để kiểm tra." -ForegroundColor White
Write-Host "👉 Kiểm tra update: '/cwf-update'" -ForegroundColor White
Write-Host ""

# Exit cleanly
exit 0
