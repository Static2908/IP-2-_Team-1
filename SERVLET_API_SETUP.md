# VS Code Servlet API Configuration Guide

**Date:** February 20, 2026  
**Java Project Type:** Non-Maven Servlet Web Application  
**Web Server:** Apache Tomcat 9.0  
**Target Java Version:** Java 8+

---

## 📋 Setup Complete - Configuration Files Created

The following VS Code configuration files have been created:

### ✅ Files Created

1. **`.vscode/settings.json`** - Java classpath and IDE settings
2. **`.vscode/launch.json`** - Debugging configuration
3. **`.vscode/tasks.json`** - Build and deployment tasks
4. **`backend/lib/`** - Directory for Tomcat servlet JARs (empty, needs population)

---

## 🚀 Step-by-Step Setup Instructions

### Step 1: Locate Your Tomcat 9 Installation

Find your Tomcat 9 installation directory. Common locations:

**Windows:**
- `C:\Program Files\Apache Tomcat 9.0`
- `C:\Tomcat9`
- `C:\tomcat`
- Custom installation path

**Find it by:**
```powershell
# Open PowerShell and run:
[Environment]::GetEnvironmentVariable("CATALINA_HOME")
```

Or search:
```powershell
Get-ChildItem "C:\" -Recurse -Name -Filter "catalina.bat" 2>/dev/null | Select-Object -First 1
```

---

### Step 2: Copy Servlet JARs from Tomcat to Your Project

Copy the following JAR files from your Tomcat `lib` directory to `backend/lib`:

```powershell
# Example if Tomcat is at C:\Program Files\Apache Tomcat 9.0

$tomcat = "C:\Program Files\Apache Tomcat 9.0"
$projectLib = "$((Get-Location).Path)\backend\lib"

# Copy essential servlet JARs
Copy-Item "$tomcat\lib\servlet-api.jar" -Destination $projectLib
Copy-Item "$tomcat\lib\jsp-api.jar" -Destination $projectLib
Copy-Item "$tomcat\lib\el-api.jar" -Destination $projectLib
Copy-Item "$tomcat\lib\catalina.jar" -Destination $projectLib
Copy-Item "$tomcat\lib\catalina-util.jar" -Destination $projectLib

Write-Host "✓ Copied servlet JARs to backend/lib"
```

**Manually (if PowerShell method doesn't work):**

1. Open Windows File Explorer
2. Navigate to: `C:\Program Files\Apache Tomcat 9.0\lib` (or your Tomcat path)
3. Copy these files to `backend/lib\`:
   - `servlet-api.jar`
   - `jsp-api.jar`
   - `el-api.jar`
   - `catalina.jar` (optional)
   - `catalina-util.jar` (optional)

---

### Step 3: Update VS Code Settings (If Needed)

If your Java installation is not at the default location, update `.vscode/settings.json`:

```json
"java.home": "C:/Program Files/Java/jdk1.8.0_281"
```

Change to your actual JDK path.

---

### Step 4: Update Tomcat Path in Tasks (If Needed)

If your Tomcat is not at `C:\Program Files\Apache Tomcat 9.0`, edit `.vscode/tasks.json`:

Find these lines:
```json
"C:/Program Files/Apache Tomcat 9.0/webapps/ROOT/WEB-INF/classes/"
```

Replace with your actual Tomcat path. Use forward slashes (`/`).

**Example:**
```json
"C:/Tomcat9/webapps/ROOT/WEB-INF/classes/"
```

---

## 🛠️ VS Code Configuration Details

### `.vscode/settings.json`

**Key settings:**

```json
"java.project.sourcePaths": [
    "backend/src",
    "ai-engine"
],
"java.project.outputPath": "backend/bin",
"java.project.referencedLibraries": [
    "backend/lib/**/*.jar"
]
```

**What it does:**
- ✅ Sets source paths to `backend/src` and `ai-engine`
- ✅ Sets output to `backend/bin`
- ✅ Automatically includes all JARs from `backend/lib/**/*.jar`

---

### `.vscode/launch.json`

**Two debugging configurations:**

1. **"Compile Java Project"** - Compiles and runs Java code
2. **"Attach to Tomcat"** - Connects debugger to running Tomcat instance (port 8000)

To debug with Tomcat:
```bash
# Start Tomcat in debug mode
set CATALINA_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000
catalina.bat jpda start
```

---

### `.vscode/tasks.json`

**Available tasks:** (Run with `Ctrl+Shift+B` or `Terminal > Run Task`)

| Task | Purpose |
|------|---------|
| **Compile Java Project** | Compile all Java files to `backend/bin` |
| **Copy compiled classes to Tomcat** | Copy `.class` files to Tomcat webapps |
| **Package WAR file** | Create `skillgap.war` for deployment |
| **Clean compiled files** | Remove `backend/bin` directory |

---

## 📂 Project Structure After Setup

```
IP-2/
├── .vscode/
│   ├── settings.json        [VS Code Java settings]
│   ├── launch.json          [Debug configuration]
│   └── tasks.json           [Build tasks]
├── backend/
│   ├── src/
│   │   └── com/skillgap/    [Source code]
│   ├── lib/                 [Tomcat JARs]
│   │   ├── servlet-api.jar
│   │   ├── jsp-api.jar
│   │   ├── el-api.jar
│   │   ├── catalina.jar
│   │   └── ...
│   ├── bin/                 [Compiled .class files - auto-generated]
│   └── [build output]
├── ai-engine/               [AI modules]
├── frontend/                [HTML/CSS/JS]
├── database/                [SQL scripts]
└── deployment/              [Docs]
```

---

## ✅ Verification Checklist

After setup, verify everything is working:

### 1. Check Classpath
```powershell
# In VS Code terminal, check if classes are recognized:
cd backend
dir lib
# Should list: servlet-api.jar, jsp-api.jar, el-api.jar, etc.
```

### 2. Test Compilation
```powershell
# Run the compile task
Ctrl+Shift+B  # Open task menu
# Select "Compile Java Project"
```

Should produce: `backend/bin/com/skillgap/**/*.class` files

### 3. Verify Servlet Imports Work
- Open `backend/src/com/skillgap/servlet/LoginServlet.java`
- Hover over `import javax.servlet.*;`
- Should NOT show red squiggles (no compilation errors)

### 4. Check IntelliSense
- Start typing: `HttpServlet`
- Should auto-complete with class suggestions
- Should resolve to `javax.servlet.http.HttpServlet`

---

## 🔧 Manual Compilation (If Tasks Don't Work)

If the VS Code tasks fail, compile manually:

```powershell
cd "C:\Users\amith\OneDrive\Documents\GitHub\IP-2"

# Compile all source files
javac -d backend/bin `
  -cp "backend/lib/*" `
  -sourcepath backend/src `
  backend/src/com/skillgap/**/*.java

# Check for errors
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Compilation successful!"
} else {
    Write-Host "✗ Compilation failed!"
}
```

---

## 📦 Deploying to Tomcat

### Option 1: Copy Compiled Classes (Development)

```powershell
# Compile first
Ctrl+Shift+B → "Compile Java Project"

# Copy to Tomcat
Copy-Item -Path "backend/bin/com" `
  -Destination "C:\Program Files\Apache Tomcat 9.0\webapps\ROOT\WEB-INF\classes\" `
  -Recurse -Force
```

### Option 2: Package as WAR (Production)

```powershell
# Creates skillgap.war for deployment
Ctrl+Shift+B → "Package WAR file"

# Then deploy to Tomcat:
# 1. Stop Tomcat
# 2. Copy skillgap.war to webapps/
# 3. Start Tomcat
# 4. Tomcat auto-expands the WAR
```

---

## 🚨 Troubleshooting

### Issue: "javax.servlet cannot be resolved"

**Solution:**
1. Verify `backend/lib/servlet-api.jar` exists
2. Check `.vscode/settings.json` has: `"java.project.referencedLibraries": ["backend/lib/**/*.jar"]`
3. Reload VS Code: `Ctrl+Shift+P` → "Reload Window"

### Issue: Compilation fails with classpath errors

**Solution:**
```powershell
# Check if lib directory has JARs
dir "backend/lib"

# If empty, copy from Tomcat:
Copy-Item "C:\Program Files\Apache Tomcat 9.0\lib\servlet-api.jar" -Destination "backend/lib\"
```

### Issue: Tasks fail with "Tomcat not found"

**Solution:**
1. Edit `.vscode/tasks.json`
2. Replace Tomcat path with your actual installation
3. Use forward slashes: `C:/Program Files/Apache Tomcat 9.0/...`

### Issue: Java extension not recognizing project

**Solution:**
```
1. Ctrl+Shift+P → "Java: Clean language server workspace"
2. Wait for reindex
3. Reload VS Code (Ctrl+Shift+P → Reload Window)
```

---

## 📋 Required Extensions

Install these VS Code extensions for best experience:

```
Extension Pack for Java (Microsoft)
  - Includes: Language Support for Java, Debugger for Java, etc.
  
Apache Tomcat for Java (wilfriedroset)
  - Optional: For direct Tomcat integration
```

Install via: `Ctrl+Shift+X` (Extensions menu)

---

## 🎯 Quick Command Reference

| Action | Command |
|--------|---------|
| **Compile** | `Ctrl+Shift+B` → "Compile Java Project" |
| **Deploy to Tomcat** | `Ctrl+Shift+B` → "Copy compiled classes to Tomcat" |
| **Clean** | `Ctrl+Shift+B` → "Clean compiled files" |
| **Debug** | `F5` → "Attach to Tomcat" (after starting Tomcat in debug mode) |
| **Reload Window** | `Ctrl+Shift+P` → "Reload Window" |
| **Open Terminal** | `` Ctrl+` `` |

---

## 📝 Next Steps

1. ✅ Copy servlet JARs from Tomcat to `backend/lib/` (see Step 2 above)
2. ✅ Verify VS Code recognizes servlet imports
3. ✅ Test compilation with `Ctrl+Shift+B`
4. ✅ Deploy compiled classes to Tomcat webapps
5. ✅ Test servlet execution in Tomcat

---

## 🔗 Resources

- **Tomcat 9 Documentation:** https://tomcat.apache.org/tomcat-9.0-doc/
- **Servlet API 3.1:** https://tomcat.apache.org/tomcat-9.0-doc/servletapi/
- **Java Extension Pack:** https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack

---

**Configuration Status:** ✅ Ready for Tomcat Deployment

Follow Step 2 (Copy Servlet JARs) to complete setup.

---

*Last Updated: February 20, 2026*
