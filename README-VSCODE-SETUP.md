# VS Code Servlet API Setup - Index

**Status:** ✅ Configuration Complete  
**Date:** February 20, 2026  
**Type:** Non-Maven Tomcat 9 Project

---

## 🎯 Start Here

### ⚡ Quick Setup (2 minutes)

1. **Run Setup Script**
   ```powershell
   .\setup-servlet-api.ps1
   ```
   (Or `setup-servlet-api.bat` if using Batch)
   - Asks for Tomcat 9 path
   - Copies servlet JARs to `backend/lib/`
   - Validates setup

2. **Reload VS Code**
   ```
   Ctrl+Shift+P  →  Reload Window
   ```

3. **Test Compilation**
   ```
   Ctrl+Shift+B  →  Compile Java Project
   ```

✅ Done! Your project is ready to use servlet API.

---

## 📚 Documentation Index

### For Different Roles

| Role | Start with | Then read |
|------|-----------|-----------|
| **Developer** | [QUICK_START.md](#quick-start) | [SERVLET_API_SETUP.md](#servlet-setup) |
| **DevOps/Admin** | [VSCODE_CONFIG_REPORT.md](#config-report) | [SERVLET_API_SETUP.md](#servlet-setup) |
| **First-time Setup** | [QUICK_START.md](#quick-start) | All of the above |

---

## 📖 Documentation Files

### QUICK_START.md {#quick-start}
**2-minute overview**
- 3-step quick start
- Build command reference
- Quick troubleshooting

### SERVLET_API_SETUP.md {#servlet-setup}
**Complete setup guide** [9,586 bytes - Long form]
- Step-by-step setup (4 steps)
- Detailed configuration explanation
- All troubleshooting scenarios
- Manual compilation instructions
- Deployment procedures
- Resource links

### VSCODE_CONFIG_REPORT.md {#config-report}
**Technical configuration report**
- All files created with contents
- Configuration details
- Project structure
- Verification checklist
- Customization guide

---

## 🛠️ Setup Files

### PowerShell Script (Recommended)
```
setup-servlet-api.ps1
```
- Interactive setup wizard
- Colored output
- Option to open VS Code after setup
- Recommended for Windows users

### Batch Script
```
setup-servlet-api.bat
```
- Windows Batch version
- Same functionality as PowerShell
- Use if PowerShell has execution policy issues

**Running the script:**
```powershell
# PowerShell
cd "C:\Users\amith\OneDrive\Documents\GitHub\IP-2"
.\setup-servlet-api.ps1
```

```batch
# Batch
cd C:\Users\amith\OneDrive\Documents\GitHub\IP-2
setup-servlet-api.bat
```

---

## 📂 VS Code Configuration

### `.vscode/settings.json`
```json
{
    "java.project.sourcePaths": ["backend/src", "ai-engine"],
    "java.project.outputPath": "backend/bin",
    "java.project.referencedLibraries": ["backend/lib/**/*.jar"]
}
```
- Sets source paths
- Sets output directory for compiled classes
- Includes all JARs from `backend/lib/`

### `.vscode/launch.json`
Debug configurations:
- Compile Java Project
- Attach to Tomcat (port 8000)

### `.vscode/tasks.json`
Build tasks:
- Compile Java Project
- Copy compiled classes to Tomcat
- Package WAR file
- Clean compiled files

Access tasks: `Ctrl+Shift+B`

---

## 🚀 Build Commands

Once setup is complete, use these:

```
Ctrl+Shift+B                           → Open task menu
  ├─ Compile Java Project              → backend/bin/
  ├─ Copy compiled classes to Tomcat   → Tomcat webapps
  ├─ Package WAR file                  → skillgap.war
  └─ Clean compiled files              → Remove bin/
```

---

## 📁 Project Structure

```
IP-2/
├── .vscode/                    [VS Code Configuration]
│   ├── settings.json          │   IDE settings
│   ├── launch.json            │   Debug config
│   └── tasks.json             │   Build tasks
│
├── backend/
│   ├── src/com/skillgap/      [Source Code]
│   │   ├── servlet/           │   6 Servlets
│   │   ├── db/                │   Database class
│   │   ├── model/             │   3 Model classes
│   │   └── util/              │   2 Utility classes
│   │
│   ├── lib/                   [Tomcat JARs]
│   │   ├── servlet-api.jar    │   After setup script
│   │   ├── jsp-api.jar
│   │   ├── el-api.jar
│   │   └── catalina.jar
│   │
│   └── bin/                   [Compiled Output]
│       └── com/skillgap/...   │   Auto-generated
│
├── ai-engine/                 [AI Modules]
├── frontend/                  [HTML/CSS/JS]
├── database/                  [SQL Scripts]
├── deployment/                [Documentation]
├── QUICK_START.md             [2-min guide]
├── SERVLET_API_SETUP.md       [Full guide]
├── VSCODE_CONFIG_REPORT.md    [Tech report]
├── setup-servlet-api.ps1      [Setup script]
└── setup-servlet-api.bat      [Setup script]
```

---

## ✅ Verification

After running setup script and reloading VS Code:

1. **Check dependencies loaded:**
   - Open any servlet file
   - Type `HttpServlet` and see auto-complete
   - Hover over import - no red squiggles

2. **Test compilation:**
   - `Ctrl+Shift+B` → "Compile Java Project"
   - Should create `backend/bin/com/skillgap/.../*.class` files

3. **Check IntelliSense:**
   - Type `HttpServletRequest` → should auto-complete
   - IntelliSense shows methods/properties

---

## 🎯 Typical Workflow

```
1. Make code changes in backend/src/
   
2. Compile: Ctrl+Shift+B → "Compile Java Project"
   
3. Deploy: Ctrl+Shift+B → "Copy compiled classes to Tomcat"
   
4. Start/Restart Tomcat
   
5. Test in browser: http://localhost:8080
   
6. Debug if needed: F5 → "Attach to Tomcat"
```

---

## 🆘 Quick Troubleshoot

| Problem | Solution |
|---------|----------|
| "Cannot find javax.servlet" | Run setup script |
| VS Code doesn't recognize changes | `Ctrl+Shift+P` → "Reload Window" |
| Compilation fails with classpath error | Verify `backend/lib/` has JARs |
| Tomcat module not found | Update Tomcat path in `.vscode/tasks.json` |

See `SERVLET_API_SETUP.md` for detailed troubleshooting.

---

## 📞 Documentation Locations

```
Quick questions              → QUICK_START.md
Deep dive/troubleshooting   → SERVLET_API_SETUP.md
Configuration details       → VSCODE_CONFIG_REPORT.md
File list                   → This file (INDEX)
```

---

## 🚀 Next Steps

1. Run `setup-servlet-api.ps1` (or `.bat`)
2. Follow on-screen prompts
3. Reload VS Code when done
4. Try building with `Ctrl+Shift+B`

---

**Everything is configured. Just run the setup script!** ✨

---

*Configuration Index - February 20, 2026*
