# Tomcat Setup and Configuration Guide

## Installing Tomcat 9.0

### 1. Prerequisites
- Java JDK 7 or higher installed (JDK 8+ recommended)
- System PATH configured for Java
- Administrator access to install services

### 2. Download Tomcat 9.0
- Visit: https://tomcat.apache.org/download-90.cgi
- Download the binary distribution (ZIP or installer)

### 3. Installation Steps (Windows)

#### Using Installer
1. Run the installer executable
2. Accept license agreement
3. Choose installation directory (e.g., `C:\Apache Tomcat 9`)
4. Configure port (default 8080)
5. Set Java Virtual Machine path
6. Complete installation

#### Using ZIP
1. Extract ZIP to desired location (e.g., `C:\Apache Tomcat 9`)
2. Create `CATALINA_HOME` environment variable pointing to Tomcat directory
3. (Optional) Register as service using `service.bat`

### 4. Directory Structure
```
tomcat/
├── bin/           - Startup/shutdown scripts
├── conf/          - Configuration files
│   ├── server.xml - Main configuration
│   └── context.xml
├── webapps/       - Deploy web applications here
├── logs/          - Log files
├── temp/          - Temporary files
└── work/          - Generated files
```

## Configuration

### 1. server.xml Configuration
Located in `conf/server.xml`

Key elements:
- `<Server>` - Root element (shutdown port: 8005)
- `<Service>` - Service container
- `<Connector>` - Connection protocols (HTTP: 8080)
- `<Engine>` - Request processing
- `<Host>` - Virtual hosts

### 2. Database Connection Pool
Add to `conf/context.xml`:
```xml
<Resource name="jdbc/skillgap_db" 
    auth="Container"
    type="javax.sql.DataSource"
    maxActive="100" 
    maxIdle="30"
    maxWait="10000"
    username="root"
    password="your_password"
    driverClassName="com.mysql.cj.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/skillgap_db"/>
```

### 3. Enable Remote Debugging
Add to `bin/catalina.bat` (Windows):
```batch
set JPDA_TRANSPORT=dt_socket
set JPDA_ADDRESS=8000
set JPDA_SUSPEND=n
```

Start with: `catalina.bat jpda start`

### 4. JVM Memory Configuration
Edit `bin/catalina.bat`:
```batch
set "CATALINA_OPTS=-Xms512M -Xmx1024M -XX:MaxPermSize=256M"
```

## Deploying Applications

### 1. Manual Deployment
- Copy WAR file to `webapps/` directory
- Tomcat auto-deploys on startup

### 2. Manager Deployment
1. Access: `http://localhost:8080/manager/html`
2. Use credentials from `conf/tomcat-users.xml`
3. Deploy via UI

### 3. Ant Deployment
- Configure `build.properties`
- Run: `ant deploy`

## Starting and Stopping Tomcat

### Windows
```batch
# Start
%CATALINA_HOME%\bin\startup.bat

# Stop
%CATALINA_HOME%\bin\shutdown.bat

# As Service
net start Tomcat9
net stop Tomcat9
```

### Linux/Mac
```bash
# Start
$CATALINA_HOME/bin/startup.sh

# Stop
$CATALINA_HOME/bin/shutdown.sh
```

## Troubleshooting

### Port Already in Use
- Change port in `server.xml` (default 8080)
- Or kill process using port 8080

### Application Not Deploying
- Check `webapps/` folder permissions
- Review `logs/catalina.out` for errors
- Verify application context root in `web.xml`

### Database Connection Issues
- Verify Oracle is running
- Check Oracle listener status: `lsnrctl status`
- Check JDBC driver in `lib/` directory (ojdbc8.jar or ojdbc10.jar)
- Verify connection string: `jdbc:oracle:thin:@localhost:1521:ORCL`
- Review connection pool configuration

## Security Configuration

### 1. Change Default Credentials
Edit `conf/tomcat-users.xml`:
```xml
<role rolename="manager-gui"/>
<role rolename="admin-gui"/>
<user username="admin" password="strong_password" roles="manager-gui,admin-gui"/>
```

### 2. Disable Unnecessary Services
- Remove example applications from `webapps/`
- Disable ROOT application if not needed
- Remove default documentation

### 3. HTTPS Configuration
Generate keystore:
```bash
keytool -genkey -alias tomcat -keyalg RSA
```

Add to `server.xml`:
```xml
<Connector port="8443" 
    scheme="https" 
    secure="true"
    keystoreFile="path/to/keystore"
    keystorePass="password"/>
```

## Performance Tuning

### Connection Pool Settings
- `maxActive`: Maximum concurrent connections (100)
- `maxIdle`: Maximum idle connections (30)
- `maxWait`: Max wait time in ms (10000)

### Thread Pool Configuration
```xml
<Executor name="tomcatThreadPool" 
    namePrefix="catalina-exec-"
    maxThreads="150" 
    minSpareThreads="4"/>
```

## Monitoring

### 1. Manager Console
- URL: `http://localhost:8080/manager/text`
- View application status
- Monitor memory usage

### 2. Log Files
- `logs/catalina.out` - Startup logs
- `logs/catalina.YYYY-MM-DD.log` - Daily logs
- `webapps/[app]/logs/` - Application-specific logs

### 3. JMX Monitoring
Enable in `catalina.sh`:
```bash
-Dcom.sun.management.jmxremote
```

## Common Issues and Solutions

| Issue | Solution |
|-------|----------|
| Slow startup | Increase heap size, check disk I/O |
| Memory leak | Check app for resource leaks, restart regularly |
| High CPU | Profile application, optimize code |
| Deployment failure | Check permissions, review logs, validate WAR |
