# 🚀 CWF - Cursor Workflow Framework v1.0

**Hệ điều hành dành cho Vibe Coder và Kỹ sư AI - Phiên bản cho Cursor IDE.**

*Biến ý tưởng thành App mà không cần biết code. AI lo trọn gói.*

[![Repo gốc](https://img.shields.io/badge/Fork_từ-AWF-orange?style=for-the-badge)](https://github.com/TUAN130294/awf)
[![Install](https://img.shields.io/badge/Cài_đặt-Global-blue?style=for-the-badge)](#-cài-đặt)

---

## 🛑 Vấn đề khi code với AI

**Bạn có từng gặp những cảnh này không?**

| Vấn đề | Mô tả |
|--------|-------|
| 🧠 **Mất trí nhớ** | AI quên cấu trúc Database sau 20 tin nhắn. Tự ý tạo bảng trùng lặp. |
| 💀 **Code ẩu** | AI đưa code thiếu an toàn, hard-code API Key, bỏ qua các trường hợp lỗi. |
| 🔄 **Vòng lặp Debug** | Sửa lỗi này đẻ ra lỗi khác. AI sửa mò mà không tìm nguyên nhân gốc rễ. |

👉 **Bạn đang dùng AI như thực tập sinh. Bạn cần phải QUẢN LÝ nó.**

---

## ✅ Giải pháp: CWF

**CWF là bộ 17+ lệnh Global cho mọi người - từ người mới đến chuyên gia.**

- 🔧 **Cài 1 lần, dùng mọi dự án**
- 🧠 **AI không bao giờ quên** (với `/save-brain` và `/recap`)
- 📋 **Code an toàn** (với `/code` - có security check)
- 🎯 **Thiết kế trước, code sau** (với `/plan`)

---

## 📦 Cài đặt

### 🪟 Windows (PowerShell)
Mở Terminal trong Cursor (Ctrl + `) và dán:

```powershell
iex "& { $(irm https://raw.githubusercontent.com/dl2811/cwf/main/install.ps1) }"
```

### 🍎 Mac / Linux (Terminal)
```bash
curl -fsSL https://raw.githubusercontent.com/dl2811/cwf/main/install.sh | sh
```

> ⚠️ **Khởi động lại Cursor sau khi cài đặt.**

---

## 🎮 Hướng dẫn sử dụng

### 🆕 Dành cho người mới (Vibe Coders)

**Chỉ có ý tưởng? Bắt đầu từ đây:**

```
/brainstorm → /init → /plan → /visualize → /code → /run → /deploy
```

| Bước | Lệnh | Mô tả |
|------|------|-------|
| 1 | `/brainstorm` | Bàn ý tưởng, AI hỏi để hiểu bạn muốn gì |
| 2 | `/init` | Khởi tạo dự án mới |
| 3 | `/plan` | Thiết kế tính năng chi tiết |
| 4 | `/visualize` | Tạo giao diện UI/UX |
| 5 | `/code` | Viết code an toàn |
| 6 | `/run` | Chạy ứng dụng |
| 7 | `/deploy` | Đưa lên production |

**Không biết làm gì tiếp?** Gõ `/next`

---

### 💼 Dành cho chuyên gia

#### 1️⃣ Giai đoạn Lập kế hoạch
| Lệnh | Mô tả |
|------|-------|
| `/init` | Khởi tạo dự án mới với git |
| `/recap` | Đầu ngày làm việc - AI đọc `.brain` để nhớ lại ngữ cảnh |
| `/plan` | **QUAN TRỌNG** - Duyệt logic TRƯỚC KHI code |

#### 2️⃣ Giai đoạn Xây dựng
| Lệnh | Mô tả |
|------|-------|
| `/visualize` | Tạo giao diện UI/UX |
| `/code` | **QUAN TRỌNG** - Code + Unit Test + Security Check |

#### 3️⃣ Giai đoạn Vận hành
| Lệnh | Mô tả |
|------|-------|
| `/debug` | Chế độ "Sherlock Holmes" - Tìm nguyên nhân gốc rễ |
| `/audit` | Kiểm tra sức khỏe dự án & bảo mật |
| `/deploy` | Đóng gói lên Production |

#### 4️⃣ Bộ nhớ
| Lệnh | Mô tả |
|------|-------|
| `/save-brain` | Lưu toàn bộ kiến thức vào file `.brain` |

> 💡 **Mẹo:** Có thể xóa chat history sau khi `/save-brain`! AI sẽ nhớ lại qua `/recap`.

---

## 📚 Danh sách lệnh đầy đủ

### 🌟 Khám phá & Bắt đầu
| Lệnh | Vai trò | Mô tả |
|------|---------|-------|
| `/brainstorm` | Đối tác | 💡 Bàn ý tưởng, nghiên cứu thị trường |
| `/init` | Founder | ✨ Khởi tạo dự án |
| `/recap` | Sử gia | 🧠 Nhớ lại context |
| `/next` | Định hướng | ➡️ Gợi ý bước tiếp theo |

### 🎯 Thiết kế & Xây dựng
| Lệnh | Vai trò | Mô tả |
|------|---------|-------|
| `/plan` | Kiến trúc sư | 📝 Thiết kế tính năng |
| `/visualize` | Designer | 🎨 Tạo UI/UX |
| `/code` | Senior Dev | � Viết code an toàn |

### ⚙️ Chạy & Kiểm tra
| Lệnh | Vai trò | Mô tả |
|------|---------|-------|
| `/run` | Operator | ▶️ Chạy ứng dụng |
| `/test` | QA Engineer | ✅ Kiểm thử |
| `/debug` | Thám tử | 🐞 Sửa lỗi sâu |

### 🚀 Triển khai & Bảo trì
| Lệnh | Vai trò | Mô tả |
|------|---------|-------|
| `/deploy` | DevOps | 🚀 Deploy lên server |
| `/audit` | Bảo mật | 🏥 Kiểm tra bảo mật |
| `/refactor` | Clean Coder | � Tối ưu code |
| `/rollback` | Time Traveler | ⏪ Khôi phục code cũ |

### 💾 Bộ nhớ & Tiện ích
| Lệnh | Vai trò | Mô tả |
|------|---------|-------|
| `/save-brain` | Thủ thư | 💾 Lưu kiến thức |
| `/customize` | Tùy chỉnh | ⚙️ Cá nhân hóa AI |
| `/cloudflare-tunnel` | Admin | 🌐 Quản lý Tunnel |
| `/cwf-update` | Updater | 🔄 Cập nhật CWF |

---

## � Tại sao cần `/brainstorm`?

**Vấn đề thường gặp:**
```
User: "Làm app quản lý tiệm cà phê"
AI: *Bắt đầu code ngay* → Thiếu features, code lại nhiều lần
```

**Với `/brainstorm`:**
```
User: "/brainstorm Làm app quản lý tiệm cà phê"
AI: 
  - Hỏi để hiểu: "Tiệm có bao nhiêu nhân viên? Cần quản lý gì?"
  - Nghiên cứu đối thủ (nếu cần)
  - Đề xuất MVP: "Ưu tiên order, inventory trước. Loyalty sau"
  - Output: BRIEF.md rõ ràng
```

---

## 🔄 Cập nhật CWF

### Kiểm tra và cập nhật
```
/cwf-update
```

### Sync với upstream AWF
Khi repo gốc AWF có update mới:

**Windows:**
```powershell
cd C:\path\to\cwf
.\sync-from-upstream.ps1
```

**Mac/Linux:**
```bash
cd /path/to/cwf
./sync-from-upstream.sh
```

---

## 📁 Vị trí cài đặt

| Thành phần | Đường dẫn |
|------------|-----------|
| Workflows | `~/.cursor/rules/cwf/` |
| Schemas | `~/.cursor/schemas/` |
| Templates | `~/.cursor/templates/` |
| Global Rules | `~/.cursor/rules/cwf-global.mdc` |
| Version | `~/.cursor/cwf_version` |

---

## 🙏 Credits

- **Fork từ:** [AWF - Antigravity Workflow Framework](https://github.com/TUAN130294/awf) by [@TUAN130294](https://github.com/TUAN130294)
- **Chuyển đổi cho Cursor:** [@dl2811](https://github.com/dl2811)

---

## 📜 License

Giống với repo gốc AWF.
