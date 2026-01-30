# ⚡ CWF v4.0 - Cursor Workflow Framework

> **Framework mở rộng cho Cursor IDE.**
> Biến AI của bạn thành một đội ngũ chuyên nghiệp (PM, Designer, Coder) với quy trình làm việc chuẩn.

[![Version](https://img.shields.io/badge/version-4.0.0-blue.svg)](https://github.com/dl2811/cwf)
[![Fork từ AWF](https://img.shields.io/badge/Fork_từ-AWF-orange?style=flat-square)](https://github.com/TUAN130294/awf)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

---

## ✨ Tính Năng Chính

- 🤖 **Multi-Persona AI**: Đội ngũ AI chuyên biệt (PM, Dev, Designer, QA)
- 🧠 **Context Vĩnh Cửu**: Tự động lưu và khôi phục session làm việc
- 📦 **All-in-One**: Không cần cài thêm bất kỳ skill/agent nào khác
- 🔄 **Auto-Update**: Tự động kiểm tra và cập nhật phiên bản mới
- 🎯 **Cursor Native**: Tối ưu cho Cursor IDE với .cursorrules

---

## 🚀 Cài Đặt (2 Bước)

### Bước 1: Cài Đặt Global

**🪟 Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/dl2811/cwf/main/install.ps1 | iex
```

**🍎 macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/dl2811/cwf/main/install.sh | sh
```

> ⚠️ **Windows: Gặp lỗi ExecutionPolicy?** Chạy lệnh này trước:
> ```powershell
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

### Bước 2: Kích Hoạt Trong Project

Mở terminal MỚI, `cd` vào project của bạn và chạy:

```bash
cwf-init
```

> ⚠️ **Restart Cursor** sau khi chạy `cwf-init`

---

## 🎮 Cách Sử Dụng

Sau khi kích hoạt, gõ lệnh vào khung Chat của Cursor:

```
/init
```

AI sẽ hỏi bạn muốn làm dự án gì và tự động hướng dẫn từng bước.

Hoặc dùng `@` để reference file workflow:
```
@plan.md Thêm tính năng thanh toán
```

---

## 🗺️ Các Lệnh Chính

### 🌟 Khám Phá & Bắt Đầu
| Lệnh | Chức năng | Mô tả |
|------|-----------|-------|
| `/init` | 🏁 Khởi động | Bắt đầu dự án mới |
| `/brainstorm` | 💡 Ý tưởng | Bàn ý tưởng, nghiên cứu thị trường |
| `/recap` | 🧠 Nhớ lại | Khôi phục context từ session cũ |
| `/next` | ➡️ Tiếp theo | Gợi ý bước tiếp theo |

### 🎯 Thiết Kế & Xây Dựng
| Lệnh | Chức năng | Mô tả |
|------|-----------|-------|
| `/plan` | 📝 Kế hoạch | AI đóng vai PM, phỏng vấn yêu cầu |
| `/visualize` | 🎨 Thiết kế | Tạo UI/UX trước khi code |
| `/code` | 💻 Viết code | AI tự động lập trình theo spec |

### ⚙️ Chạy & Kiểm Tra
| Lệnh | Chức năng | Mô tả |
|------|-----------|-------|
| `/run` | ▶️ Chạy | Khởi động ứng dụng |
| `/test` | ✅ Kiểm thử | Chạy test cases |
| `/debug` | 🐛 Sửa lỗi | Phân tích và fix bug tự động |

### 🚀 Triển Khai & Bảo Trì
| Lệnh | Chức năng | Mô tả |
|------|-----------|-------|
| `/deploy` | 🚀 Deploy | Đẩy lên production |
| `/audit` | 🏥 Kiểm tra | Kiểm tra bảo mật |
| `/refactor` | 🧹 Tối ưu | Dọn dẹp và tối ưu code |
| `/rollback` | ⏪ Rollback | Khôi phục phiên bản cũ |

### 💾 Bộ Nhớ & Tiện Ích
| Lệnh | Chức năng | Mô tả |
|------|-----------|-------|
| `/save-brain` | 💾 Lưu | Lưu kiến thức dự án |
| `/customize` | ⚙️ Tùy chỉnh | Cá nhân hóa AI |
| `/cwf-update` | 🔄 Cập nhật | Kiểm tra và update CWF |

---

## 📂 Cấu Trúc Thư Mục (Sau Cài Đặt)

```
~/.cursor/cwf/               # Global (cài 1 lần)
├── workflows/               # Các workflow chính (/init, /plan, /code...)
├── skills/                  # CWF Skills (auto-activate)
├── schemas/                 # JSON Schemas
├── templates/               # Mẫu cấu hình
├── cwf-init.ps1            # Script kích hoạt (Windows)
└── cwf-init                 # Script kích hoạt (Mac/Linux)

your-project/                # Sau khi chạy cwf-init
├── .cursor/rules/           # Workflows được copy vào đây
│   ├── plan.md
│   ├── code.md
│   └── ...
└── .cursorrules             # File rules cho Cursor
```

---

## 🔄 Cập Nhật

### Cập nhật CWF
Gõ trong Cursor chat:
```
/cwf-update
```

### Sync với upstream AWF (Dành cho Maintainer)
```powershell
# Windows
.\sync-from-upstream.ps1

# Mac/Linux
./sync-from-upstream.sh
```

---

## 📜 Changelog

### v4.0.0 (Latest)
- 🆕 **Skill System**: awf-session-restore, awf-error-translator, awf-adaptive-language
- 🆕 **Schemas & Templates**: Cấu trúc dữ liệu chuẩn
- 🆕 **Multi-Persona AI**: Đội ngũ AI chuyên biệt
- ✅ Sync từ AWF v4.0

### v1.0.0
- 🎉 Initial release - Fork từ AWF cho Cursor IDE

---

## 🙏 Credits

- **Fork từ:** [AWF](https://github.com/TUAN130294/awf) by [@TUAN130294](https://github.com/TUAN130294)
- **Chuyển đổi cho Cursor:** [@dl2811](https://github.com/dl2811)

---

**Happy Vibe Coding!** 🚀
