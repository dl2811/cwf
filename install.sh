#!/bin/bash
# CWF - Cursor Workflow Framework (Fork of AWF)
# Converted for Cursor IDE compatibility
# Original: https://github.com/TUAN130294/awf

REPO_BASE="https://raw.githubusercontent.com/dl2811/cwf/main"
REPO_URL="$REPO_BASE/workflows"

WORKFLOWS=(
    "plan.md" "code.md" "visualize.md" "deploy.md"
    "debug.md" "refactor.md" "test.md" "run.md"
    "init.md" "recap.md" "rollback.md" "save_brain.md"
    "audit.md" "cloudflare-tunnel.md" "cwf-update.md"
    "brainstorm.md" "next.md" "customize.md" "README.md"
)

SCHEMAS=("brain.schema.json" "session.schema.json" "preferences.schema.json")
TEMPLATES=("brain.example.json" "session.example.json" "preferences.example.json")

# Cursor paths
CURSOR_GLOBAL="$HOME/.cursor/rules/cwf"
SCHEMAS_DIR="$HOME/.cursor/schemas"
TEMPLATES_DIR="$HOME/.cursor/templates"
CURSOR_RULES_DIR="$HOME/.cursor/rules"
CWF_VERSION_FILE="$HOME/.cursor/cwf_version"

# Get version from repo
CURRENT_VERSION=$(curl -sL "$REPO_BASE/VERSION" 2>/dev/null || echo "1.0.0")

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║     🚀 CWF - Cursor Workflow Framework v$CURRENT_VERSION          ║"
echo "║     (Fork of AWF for Cursor IDE)                         ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# Check if updating
if [ -f "$CWF_VERSION_FILE" ]; then
    OLD_VERSION=$(cat "$CWF_VERSION_FILE")
    echo "📦 Phiên bản hiện tại: $OLD_VERSION"
    echo "📦 Phiên bản mới: $CURRENT_VERSION"
    echo ""
fi

# 1. Create directories
mkdir -p "$CURSOR_GLOBAL"
mkdir -p "$SCHEMAS_DIR"
mkdir -p "$TEMPLATES_DIR"
mkdir -p "$CURSOR_RULES_DIR"

echo "📂 Cursor Global: $CURSOR_GLOBAL"
echo ""

# 2. Download workflows
echo "⏳ Đang tải workflows..."
success=0
for wf in "${WORKFLOWS[@]}"; do
    if curl -sL "$REPO_URL/$wf" -o "$CURSOR_GLOBAL/$wf" 2>/dev/null; then
        echo "   ✅ $wf"
        ((success++))
    else
        echo "   ❌ $wf"
    fi
done

# 3. Download schemas
echo "⏳ Đang tải schemas..."
for schema in "${SCHEMAS[@]}"; do
    if curl -sL "$REPO_BASE/schemas/$schema" -o "$SCHEMAS_DIR/$schema" 2>/dev/null; then
        echo "   ✅ $schema"
        ((success++))
    else
        echo "   ❌ $schema"
    fi
done

# 4. Download templates
echo "⏳ Đang tải templates..."
for template in "${TEMPLATES[@]}"; do
    if curl -sL "$REPO_BASE/templates/$template" -o "$TEMPLATES_DIR/$template" 2>/dev/null; then
        echo "   ✅ $template"
        ((success++))
    else
        echo "   ❌ $template"
    fi
done

# 5. Save version
echo "$CURRENT_VERSION" > "$CWF_VERSION_FILE"
echo "✅ Đã lưu version: $CURRENT_VERSION"

# 6. Create Global Rules file
cat > "$CURSOR_RULES_DIR/cwf-global.mdc" << 'EOF'
---
description: CWF - Cursor Workflow Framework
globs: 
alwaysApply: true
---

# CWF - Cursor Workflow Framework

## CRITICAL: Command Recognition
Khi user gõ các lệnh bắt đầu bằng `/` dưới đây, đây là CWF WORKFLOW COMMANDS (không phải file path).
Bạn PHẢI đọc file workflow tương ứng và thực hiện theo hướng dẫn trong đó.

## Command Mapping (QUAN TRỌNG):
| Command | Workflow File | Mô tả |
|---------|--------------|-------|
| `/brainstorm` | ~/.cursor/rules/cwf/brainstorm.md | 💡 Bàn ý tưởng, research thị trường |
| `/plan` | ~/.cursor/rules/cwf/plan.md | Thiết kế tính năng |
| `/code` | ~/.cursor/rules/cwf/code.md | Viết code an toàn |
| `/visualize` | ~/.cursor/rules/cwf/visualize.md | Tạo UI/UX |
| `/debug` | ~/.cursor/rules/cwf/debug.md | Sửa lỗi sâu |
| `/test` | ~/.cursor/rules/cwf/test.md | Kiểm thử |
| `/run` | ~/.cursor/rules/cwf/run.md | Chạy ứng dụng |
| `/deploy` | ~/.cursor/rules/cwf/deploy.md | Deploy production |
| `/init` | ~/.cursor/rules/cwf/init.md | Khởi tạo dự án |
| `/recap` | ~/.cursor/rules/cwf/recap.md | Khôi phục ngữ cảnh |
| `/next` | ~/.cursor/rules/cwf/next.md | Gợi ý bước tiếp theo |
| `/customize` | ~/.cursor/rules/cwf/customize.md | ⚙️ Cá nhân hóa AI |
| `/save-brain` | ~/.cursor/rules/cwf/save_brain.md | Lưu kiến thức |
| `/audit` | ~/.cursor/rules/cwf/audit.md | Kiểm tra bảo mật |
| `/refactor` | ~/.cursor/rules/cwf/refactor.md | Tái cấu trúc code |
| `/rollback` | ~/.cursor/rules/cwf/rollback.md | Rollback deployment |
| `/cloudflare-tunnel` | ~/.cursor/rules/cwf/cloudflare-tunnel.md | Quản lý tunnel |
| `/cwf-update` | ~/.cursor/rules/cwf/cwf-update.md | Cập nhật CWF |

## Resource Locations:
- Schemas: ~/.cursor/schemas/
- Templates: ~/.cursor/templates/

## Hướng dẫn thực hiện:
1. Khi user gõ một trong các commands trên, ĐỌC FILE WORKFLOW tương ứng
2. Thực hiện TỪNG GIAI ĐOẠN trong workflow
3. KHÔNG tự ý bỏ qua bước nào
4. Kết thúc bằng NEXT STEPS menu như trong workflow

## Update Check:
- CWF version: ~/.cursor/cwf_version
- Update command: /cwf-update
EOF

echo "✅ Đã tạo Global Rules (cwf-global.mdc)"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 HOÀN TẤT! Đã cài $success files vào hệ thống."
echo "📦 Version: $CURRENT_VERSION"
echo ""
echo "📂 Workflows: $CURSOR_GLOBAL"
echo "📂 Schemas:   $SCHEMAS_DIR"
echo "📂 Templates: $TEMPLATES_DIR"
echo ""
echo "👉 Bạn có thể dùng CWF ở BẤT KỲ project nào ngay lập tức!"
echo "👉 Thử gõ '/plan' để kiểm tra."
echo "👉 Kiểm tra update: '/cwf-update'"
echo ""
