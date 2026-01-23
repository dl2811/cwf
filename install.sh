#!/bin/bash
# CWF - Cursor Workflow Framework
# Cài đặt Global + Tạo script cwf-init để kích hoạt trong mỗi project

REPO_BASE="https://raw.githubusercontent.com/dl2811/cwf/main"
REPO_URL="$REPO_BASE/workflows"

WORKFLOWS=(
    "plan.md" "code.md" "visualize.md" "deploy.md"
    "debug.md" "refactor.md" "test.md" "run.md"
    "init.md" "recap.md" "rollback.md" "save_brain.md"
    "audit.md" "cloudflare-tunnel.md" "cwf-update.md"
    "brainstorm.md" "next.md" "customize.md"
)

SCHEMAS=("brain.schema.json" "session.schema.json" "preferences.schema.json")
TEMPLATES=("brain.example.json" "session.example.json" "preferences.example.json")

# Paths
CWF_GLOBAL="$HOME/.cursor/cwf"
SCHEMAS_DIR="$HOME/.cursor/cwf/schemas"
TEMPLATES_DIR="$HOME/.cursor/cwf/templates"
WORKFLOWS_DIR="$HOME/.cursor/cwf/workflows"
CWF_VERSION_FILE="$HOME/.cursor/cwf_version"

# Get version
CURRENT_VERSION=$(curl -sL "$REPO_BASE/VERSION" 2>/dev/null || echo "1.0.0")

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║     🚀 CWF - Cursor Workflow Framework v$CURRENT_VERSION          ║"
echo "║     (Optimized for Cursor IDE)                          ║"
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
echo "📂 Bước 1: Tạo thư mục..."
mkdir -p "$CWF_GLOBAL"
mkdir -p "$SCHEMAS_DIR"
mkdir -p "$TEMPLATES_DIR"
mkdir -p "$WORKFLOWS_DIR"
echo "   ✅ Đã tạo: $CWF_GLOBAL"

# 2. Download workflows
echo ""
echo "⏳ Bước 2: Đang tải workflows..."
success=0
for wf in "${WORKFLOWS[@]}"; do
    if curl -sL "$REPO_URL/$wf" -o "$WORKFLOWS_DIR/$wf" 2>/dev/null; then
        echo "   ✅ $wf"
        ((success++))
    else
        echo "   ❌ $wf"
    fi
done

# 3. Download schemas
echo ""
echo "⏳ Bước 3: Đang tải schemas..."
for schema in "${SCHEMAS[@]}"; do
    if curl -sL "$REPO_BASE/schemas/$schema" -o "$SCHEMAS_DIR/$schema" 2>/dev/null; then
        echo "   ✅ $schema"
        ((success++))
    else
        echo "   ❌ $schema"
    fi
done

# 4. Download templates
echo ""
echo "⏳ Bước 4: Đang tải templates..."
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
echo ""
echo "✅ Đã lưu version: $CURRENT_VERSION"

# 6. Create cwf-init script
echo ""
echo "🔧 Bước 5: Tạo script cwf-init..."

cat > "$CWF_GLOBAL/cwf-init" << 'CWFINIT'
#!/bin/bash
# CWF Init - Kích hoạt CWF trong project hiện tại

CWF_GLOBAL="$HOME/.cursor/cwf/workflows"
PROJECT_RULES="./.cursor/rules"

echo ""
echo "🚀 CWF Init - Kích hoạt workflows cho project này"
echo ""

# Check if CWF is installed
if [ ! -d "$CWF_GLOBAL" ]; then
    echo "❌ CWF chưa được cài đặt. Chạy install.sh trước!"
    exit 1
fi

# Create .cursor/rules folder
mkdir -p "$PROJECT_RULES"
echo "📂 Đã tạo: $PROJECT_RULES"

# Copy workflows to project
echo "📝 Đang copy workflows..."
copied=0
for file in "$CWF_GLOBAL"/*.md; do
    if [ -f "$file" ]; then
        cp "$file" "$PROJECT_RULES/"
        echo "   ✅ $(basename $file)"
        ((copied++))
    fi
done

# Create main .cursorrules file
cat > "./.cursorrules" << 'CURSORRULES'
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
CURSORRULES

echo ""
echo "✅ Đã tạo .cursorrules"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 HOÀN TẤT! Đã kích hoạt CWF cho project này."
echo ""
echo "📂 Workflows: $PROJECT_RULES ($copied files)"
echo ""
echo "👉 Restart Cursor và thử gõ: /plan hoặc /brainstorm"
echo "👉 Hoặc dùng @ để reference: @plan.md"
echo ""
CWFINIT

chmod +x "$CWF_GLOBAL/cwf-init"
echo "   ✅ cwf-init"

# 7. Add to PATH
echo ""
echo "🔧 Bước 6: Thêm vào PATH..."

# Detect shell config file
if [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
else
    SHELL_CONFIG="$HOME/.profile"
fi

# Add to PATH if not already there
if ! grep -q "\.cursor/cwf" "$SHELL_CONFIG" 2>/dev/null; then
    echo "" >> "$SHELL_CONFIG"
    echo "# CWF - Cursor Workflow Framework" >> "$SHELL_CONFIG"
    echo 'export PATH="$HOME/.cursor/cwf:$PATH"' >> "$SHELL_CONFIG"
    echo "   ✅ Đã thêm vào $SHELL_CONFIG"
else
    echo "   ✅ Đã có trong PATH"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 CÀI ĐẶT HOÀN TẤT!"
echo "📦 Version: $CURRENT_VERSION"
echo ""
echo "📂 CWF Global: $CWF_GLOBAL"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "👉 BƯỚC TIẾP THEO:"
echo "   1. Chạy: source $SHELL_CONFIG (hoặc mở terminal mới)"
echo "   2. cd vào project của bạn"
echo "   3. Chạy: cwf-init"
echo "   4. Restart Cursor"
echo "   5. Dùng: /plan, /code, /brainstorm, ..."
echo ""
