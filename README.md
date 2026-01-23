# 🚀 CWF - Cursor Workflow Framework

**Fork of [AWF](https://github.com/TUAN130294/awf) adapted for Cursor IDE.**

*The Operating System for Vibe Coders & AI Engineers - Now for Cursor!*

---

## 📦 Installation (Global)

**Install once. Works on every project.**

### 🪟 Windows (PowerShell)
Open Terminal in Cursor (Ctrl + `) and paste:

```powershell
iex "& { $(irm https://raw.githubusercontent.com/dl2811/cwf/main/install.ps1) }"
```

### 🍎 Mac / Linux (Terminal)
```bash
curl -fsSL https://raw.githubusercontent.com/dl2811/cwf/main/install.sh | sh
```

> **Restart Cursor after installation.**

---

## 🎮 How to Use

Just type a command in Cursor chat:

| Command | Description |
|---------|-------------|
| `/brainstorm` | 💡 Brainstorm ideas |
| `/plan` | 📝 Design features |
| `/code` | 💻 Write code safely |
| `/visualize` | 🎨 Create UI/UX |
| `/debug` | 🐞 Fix bugs |
| `/test` | ✅ Run tests |
| `/run` | ▶️ Run application |
| `/deploy` | 🚀 Deploy to production |
| `/init` | ✨ Initialize project |
| `/recap` | 🧠 Summarize context |
| `/next` | ➡️ What to do next? |
| `/cwf-update` | 🔄 Update CWF |

---

## 🔄 Syncing with Upstream AWF

When the original AWF repo has updates:

### Windows
```powershell
.\sync-from-upstream.ps1
```

### Mac/Linux
```bash
./sync-from-upstream.sh
```

This will:
1. Fetch updates from upstream AWF
2. Merge into your fork (no auto-commit)
3. Let you review and resolve any conflicts
4. You commit and push when ready

---

## 📁 Installation Paths

| Component | Path |
|-----------|------|
| Workflows | `~/.cursor/rules/cwf/` |
| Schemas | `~/.cursor/schemas/` |
| Templates | `~/.cursor/templates/` |
| Global Rules | `~/.cursor/rules/cwf-global.mdc` |

---

## 🙏 Credits

- Original AWF by [@TUAN130294](https://github.com/TUAN130294/awf)
- Cursor adaptation by [@dl2811](https://github.com/dl2811)

---

## 📜 License

Same as original AWF repository.
