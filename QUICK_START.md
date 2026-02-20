# VS Code Servlet API Configuration - Quick Start

**Status:** ✅ Configuration Complete  
**Date:** February 20, 2026

---

## 🚀 Quick Start (3 Steps)

### 1. Run Setup Script
Choose one of the scripts to copy servlet JARs from Tomcat:

**Option A: PowerShell (Recommended)**
```powershell
cd "C:\Users\amith\OneDrive\Documents\GitHub\IP-2"
.\setup-servlet-api.ps1
```

**Option B: Batch Script**
```batch
cd C:\Users\amith\OneDrive\Documents\GitHub\IP-2
setup-servlet-api.bat
```

The script will ask for your Tomcat 9 installation path, then copy JARs to `backend/lib/`.

---

### 2. Reload VS Code
```
Ctrl+Shift+P  →  "Reload Window"
```

Wait for the Java language server to reindex the project (look for status bar messages).

---

### 3. Test It!
Open file: `backend/src/com/skillgap/servlet/AssessmentServlet.java`

Check that these imports work (no red squiggles):
```java
import javax.servlet.*;
import javax.servlet.http.*;
```

If IntelliSense shows suggestions, you're ready to go! ✓

---

## 📁 What Was Created

| File | Purpose |
|------|---------|
| `.vscode/settings.json` | VS Code Java configuration (classpath, output paths) |
| `.vscode/launch.json` | Debug configuration (for attaching to Tomcat) |
| `.vscode/tasks.json` | Build tasks (compile, deploy, package) |
| `backend/lib/` | Directory for servlet JARs (initial setup) |
| `setup-servlet-api.ps1` | PowerShell script to copy JARs from Tomcat |
| `setup-servlet-api.bat` | Batch script to copy JARs from Tomcat |
| `SERVLET_API_SETUP.md` | Complete setup documentation |

---

## 🛠️ Build Commands

After setup, compile and deploy using these shortcuts:

```
Ctrl+Shift+B      →  Open task menu
↓ Select one:

• Compile Java Project
  Compiles backend/src to backend/bin

• Copy compiled classes to Tomcat
  Deploys .class files to Tomcat webapps

• Package WAR file
  Creates skillgap.war for production

• Clean compiled files
  Removes backend/bin directory
```

---

## 🎯 Your Next Actions

1. **Run setup script** (see Step 1 above)
2. **Reload VS Code** (see Step 2)
3. **Verify imports** (see Step 3)
4. **Compile Java code:** `Ctrl+Shift+B` → "Compile Java Project"
5. **Deploy to Tomcat:** `Ctrl+Shift+B` → "Copy compiled classes to Tomcat"
6. **Start Tomcat and test**

---

## ❓ Troubleshooting

**"Cannot find javax.servlet"**
- Run setup script to copy JARs
- Reload VS Code

**"Compilation failed"**
- Check `backend/lib/` has JAR files
- Run: `Ctrl+Shift+B` → "Compile Java Project"

**"Tomcat path not found"**
- Verify Tomcat 9 is installed
- Use correct path in setup script

**See:** `SERVLET_API_SETUP.md` for detailed troubleshooting

---

## 📊 Project Structure After Setup

```
IP-2/
├── .vscode/
│   ├── settings.json      ← Java classpath config
│   ├── launch.json        ← Debug config
│   └── tasks.json         ← Build tasks
├── backend/
│   ├── src/
│   │   └── com/skillgap/  ← Your source code
│   ├── lib/               ← Servlet JARs (from Tomcat)
│   │   ├── servlet-api.jar
│   │   ├── jsp-api.jar
│   │   └── ...
│   └── bin/               ← Compiled .class files
├── setup-servlet-api.ps1  ← Setup script (PowerShell)
├── setup-servlet-api.bat  ← Setup script (Batch)
└── SERVLET_API_SETUP.md   ← Full documentation
```

---

## ✨ Key Features

✅ **Non-Maven Setup** - Uses vanilla Java + Tomcat (as requested)  
✅ **VS Code Integrated** - Full IntelliSense and debugging support  
✅ **Manual Deployment** - Deploy directly to Tomcat webapps  
✅ **Build Tasks Included** - Compile, deploy, package with shortcuts  
✅ **Trouble-free** - Automatic classpath management

---

**Ready to code!** 🚀

For questions, see `SERVLET_API_SETUP.md`.

---
