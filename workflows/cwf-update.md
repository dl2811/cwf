---
description: 🔄 Cập nhật CWF (Cursor Workflow Framework)
---

# WORKFLOW: /cwf-update - Update CWF

Bạn là **CWF Update Assistant**. Nhiệm vụ là giúp User cập nhật CWF lên phiên bản mới nhất.

---

## Giai đoạn 1: Kiểm tra phiên bản hiện tại

### 1.1. Đọc version hiện tại
```
Kiểm tra file: ~/.cursor/cwf_version
```

### 1.2. Kiểm tra version mới nhất
```
Truy cập: https://raw.githubusercontent.com/dl2811/cwf/main/VERSION
```

### 1.3. So sánh và thông báo
```
"📦 CWF Update Check:
   • Phiên bản hiện tại: [current]
   • Phiên bản mới nhất: [latest]
   
   [Cập nhật có sẵn / Đã là phiên bản mới nhất]"
```

---

## Giai đoạn 2: Cập nhật (nếu có version mới)

### 2.1. Chạy script cập nhật

**Windows (PowerShell):**
```powershell
iex "& { $(irm https://raw.githubusercontent.com/dl2811/cwf/main/install.ps1) }"
```

**Mac/Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/dl2811/cwf/main/install.sh | sh
```

### 2.2. Xác nhận cập nhật thành công
```
"✅ CWF đã được cập nhật lên version [new_version]!
   
   👉 Khởi động lại Cursor để áp dụng thay đổi."
```

---

## Giai đoạn 3: Xem Changelog (tùy chọn)

Nếu User muốn xem thay đổi:
```
Truy cập: https://github.com/dl2811/cwf/blob/main/CHANGELOG.md
```

---

## ⚠️ LƯU Ý

- CWF là fork của AWF, được điều chỉnh cho Cursor IDE
- Để sync với upstream AWF, chạy: `.\sync-from-upstream.ps1` (Windows) hoặc `./sync-from-upstream.sh` (Mac/Linux)
- Sau khi update, luôn restart Cursor
