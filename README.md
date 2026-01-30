# 🚀 CWF - Cursor Workflow Framework v1.0

**Hệ điều hành dành cho Vibe Coder và Kỹ sư AI - Phiên bản cho Cursor IDE.**

*Biến ý tưởng thành App mà không cần biết code. AI lo trọn gói.*

[![Fork từ CWF](https://img.shields.io/badge/Fork_từ-CWF-orange?style=for-the-badge)](https://github.com/TUAN130294/CWF)

---

## 📦 Cài đặt (2 bước)

### Bước 1: Cài đặt Global

**🪟 Windows (PowerShell):**
```powershell
iex "& { $(irm https://raw.githubusercontent.com/dl2811/cwf/main/install.ps1) }"
```

**🍎 Mac / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/dl2811/cwf/main/install.sh | sh
```

### Bước 2: Kích hoạt trong Project

Mở terminal MỚI, `cd` vào project của bạn và chạy:

```bash
cwf-init
```

> ⚠️ **Restart Cursor** sau khi chạy `cwf-init`

---

## 🎮 Cách sử dụng

Sau khi kích hoạt, gõ lệnh trong Cursor chat:

```
/plan Thêm tính năng thanh toán
```

hoặc dùng `@` để reference file:

```
@plan.md Thêm tính năng thanh toán
```

---

## 📚 Danh sách lệnh

### 🌟 Khám phá & Bắt đầu
| Lệnh | Mô tả |
|------|-------|
| `/brainstorm` | 💡 Bàn ý tưởng, nghiên cứu thị trường |
| `/init` | ✨ Khởi tạo dự án |
| `/recap` | 🧠 Nhớ lại context |
| `/next` | ➡️ Gợi ý bước tiếp theo |

### 🎯 Thiết kế & Xây dựng
| Lệnh | Mô tả |
|------|-------|
| `/plan` | 📝 Thiết kế tính năng |
| `/visualize` | 🎨 Tạo UI/UX |
| `/code` | 💻 Viết code an toàn |

### ⚙️ Chạy & Kiểm tra
| Lệnh | Mô tả |
|------|-------|
| `/run` | ▶️ Chạy ứng dụng |
| `/test` | ✅ Kiểm thử |
| `/debug` | 🐞 Sửa lỗi sâu |

### 🚀 Triển khai & Bảo trì
| Lệnh | Mô tả |
|------|-------|
| `/deploy` | 🚀 Deploy lên server |
| `/audit` | 🏥 Kiểm tra bảo mật |
| `/refactor` | 🧹 Tối ưu code |
| `/rollback` | ⏪ Khôi phục code cũ |

### 💾 Bộ nhớ & Tiện ích
| Lệnh | Mô tả |
|------|-------|
| `/save-brain` | 💾 Lưu kiến thức |
| `/customize` | ⚙️ Cá nhân hóa AI |
| `/cwf-update` | 🔄 Cập nhật CWF |

---

## 🔄 Cập nhật

### Cập nhật CWF
```
/cwf-update
```

### Sync với upstream CWF
```powershell
# Windows
.\sync-from-upstream.ps1

# Mac/Linux
./sync-from-upstream.sh
```

---

## 📁 Cấu trúc

```
~/.cursor/cwf/              # Global (cài 1 lần)
├── workflows/              # Tất cả workflow files
├── schemas/                # JSON schemas
├── templates/              # Templates
├── cwf-init.ps1           # Script kích hoạt (Windows)
└── cwf-init               # Script kích hoạt (Mac/Linux)

your-project/               # Sau khi chạy cwf-init
├── .cursor/rules/          # Workflows được copy vào đây
│   ├── plan.md
│   ├── code.md
│   └── ...
└── .cursorrules            # File rules cho Cursor
```

---

## 🙏 Credits

- **Fork từ:** [CWF](https://github.com/TUAN130294/CWF) by [@TUAN130294](https://github.com/TUAN130294)
- **Chuyển đổi cho Cursor:** [@dl2811](https://github.com/dl2811)

