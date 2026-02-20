# Deployment Steps for AI Skill Gap Analysis System

## Prerequisites Checklist
- [ ] Java JDK 7+ installed and configured (JDK 8+ recommended)
- [ ] Apache Tomcat 9.0+ installed
- [ ] Oracle Database running (11g R2 or higher)
- [ ] Oracle JDBC driver (ojdbc8.jar or ojdbc10.jar) in Tomcat lib folder
- [ ] Database created and schema imported
- [ ] Environment variables configured

## Step 1: Database Setup

### 1.1 Create Oracle User and Tablespace
```sql
-- Connect as SYSDBA
CREATE TABLESPACE skillgap_ts 
  DATAFILE 'skillgap_ts.dbf' SIZE 100M AUTOEXTEND ON NEXT 50M;

CREATE USER skillgap_user IDENTIFIED BY your_password
  DEFAULT TABLESPACE skillgap_ts
  QUOTA UNLIMITED ON skillgap_ts;

-- Grant permissions
GRANT CREATE SESSION TO skillgap_user;
GRANT CREATE TABLE TO skillgap_user;
GRANT CREATE SEQUENCE TO skillgap_user;
GRANT UNLIMITED TABLESPACE TO skillgap_user;
```

### 1.2 Import Schema
Connect as skillgap_user and execute:
```sql
@/path/to/database/schema.sql
@/path/to/database/sample_data.sql
```

### 1.3 Verify Setup
```sql
SELECT * FROM users;
SELECT * FROM students;
SELECT * FROM skills;
```

## Step 2: Build Application

### 2.1 With Maven
```bash
cd backend/
mvn clean package
# Creates: target/skillgap-app.war
```

### 2.2 With Gradle
```bash
gradle clean build
# Creates: build/libs/skillgap-app.war
```

### 2.3 Build Frontend Assets
```bash
# Copy frontend files to webapp static resources
cp -r frontend/css /* backend/src/main/webapp/css/
cp -r frontend/js /* backend/src/main/webapp/js/
cp -r frontend/*.html backend/src/main/webapp/
```

## Step 3: Configure Tomcat

### 3.1 Database Connection Pool
Edit `$CATALINA_HOME/conf/context.xml`:
```xml
<Context>
    <Resource name="jdbc/skillgap_db" 
        auth="Container"
        type="javax.sql.DataSource"
        maxActive="100" 
        maxIdle="30"
        maxWait="10000"
        username="skillgap_user"
        password="your_password"
        driverClassName="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@localhost:1521:ORCL"/>
</Context>
```

### 3.2 Configure Port (Optional)
Edit `$CATALINA_HOME/conf/server.xml`:
```xml
<Connector port="8080" protocol="HTTP/1.1" 
    connectionTimeout="20000" redirectPort="8443" />
```

### 3.3 Set Java Memory Options
Windows (`bin/setenv.bat`):
```batch
set CATALINA_OPTS=-Xms512M -Xmx1024M
```

Linux (`bin/setenv.sh`):
```bash
export CATALINA_OPTS="-Xms512M -Xmx1024M"
```

## Step 4: Deploy Application

### Method 1: Copy WAR to webapps
```bash
cp backend/target/skillgap-app.war $CATALINA_HOME/webapps/ROOT.war
```

### Method 2: Manager Console
1. Open http://localhost:8080/manager
2. Login with tomcat credentials
3. Deploy from WAR file path or upload WAR

### Method 3: Ant Script
Configure `build.properties`:
```properties
tomcat.home=C:/Apache Tomcat 10
tomcat.manager.url=http://localhost:8080/manager/text
tomcat.manager.username=admin
tomcat.manager.password=admin
```

Deploy:
```bash
ant deploy
```

## Step 5: Start Application

### 5.1 Start Tomcat
Windows:
```bash
%CATALINA_HOME%\bin\startup.bat
```

Linux/Mac:
```bash
$CATALINA_HOME/bin/startup.sh
```

### 5.2 Verify Deployment
Check log: `$CATALINA_HOME/logs/catalina.out`

Expected output:
```
[Server] Server startup in [X] ms
```

## Step 6: Verify Application

### 6.1 Check URL
- Frontend: http://localhost:8080/
- Login page: http://localhost:8080/login.html
- Dashboard: http://localhost:8080/dashboard.jsp

### 6.2 Test Login
- Username: `student1`
- Password: `password123`

### 6.3 Check Database Connection
- Navigate to dashboard
- Verify student info loads correctly

### 6.4 Logs
Monitor logs for errors:
```bash
tail -f $CATALINA_HOME/logs/catalina.out
```

## Step 7: Production Configuration

### 7.1 Security Settings
Change default passwords:
```bash
Edit $CATALINA_HOME/conf/tomcat-users.xml
```

### 7.2 SSL/HTTPS Configuration
Generate certificate:
```bash
keytool -genkey -alias tomcat -keyalg RSA -keysize 2048 -validity 365
```

### 7.3 Remove Example Apps
```bash
rm -rf $CATALINA_HOME/webapps/examples
rm -rf $CATALINA_HOME/webapps/docs
rm -rf $CATALINA_HOME/webapps/host-manager
```

### 7.4 Configure Manager
Edit `conf/Catalina/localhost/manager.xml`:
- Restrict access to trusted IPs only
- Use strong authentication credentials

## Step 8: Monitoring and Maintenance

### 8.1 Set Up Log Rotation
Configure `conf/logging.properties` for daily rotation

### 8.2 Monitor Performance
- Use Tomcat Manager Console
- Monitor database connections
- Check JVM heap usage

### 8.3 Backup Strategy
- Regular database backups
- Backup uploaded files
- Schedule automated backups

### 8.4 Regular Updates
- Check for Tomcat security patches
- Update dependencies
- Review application logs regularly

## Troubleshooting

### Application won't start
1. Check Java version: `java -version` (Requires JDK 7+)
2. Check Tomcat logs: `$CATALINA_HOME/logs/catalina.out` or `catalina.YYYY-MM-DD.log`
3. Verify database connectivity
4. Check if CATALINA_HOME environment variable is properly set

### Port 8080 in use
```bash
# Windows
netstat -ano | findstr :8080
taskkill /PID [PID] /F

# Linux
lsof -i :8080
kill [PID]
```

### Database connection failed
- Verify Oracle is running
- Check credentials in context.xml (user: skillgap_user)
- Verify Oracle JDBC driver in `$CATALINA_HOME/lib/ojdbc8.jar` or `ojdbc10.jar`
- Check Oracle listener status: `lsnrctl status`
- Verify connection string: `jdbc:oracle:thin:@localhost:1521:ORCL` (adjust SID/Service Name if different)

### Application crashes
- Check heap memory settings
- Review application logs
- Check database logs
- Verify resource availability

## Rollback Steps

If deployment fails:
1. Stop Tomcat: `$CATALINA_HOME/bin/shutdown.sh`
2. Remove failed deployment: `rm $CATALINA_HOME/webapps/ROOT.war`
3. Restore previous version
4. Start Tomcat again

## Performance Optimization

### JVM Tuning
```
-Xms512M    # Initial heap
-Xmx1024M   # Maximum heap
-XX:+UseG1GC  # Garbage collector
```

### Connection Pool
- maxActive: 100
- maxIdle: 30
- maxWait: 10000ms

### Compression
Enable gzip in server.xml:
```xml
<Connector ... compression="on" compressionMinSize="2048" />
```

## Deployment Checklist
- [ ] Database created and populated
- [ ] Application built successfully
- [ ] Tomcat configured with DB connection
- [ ] WAR file deployed
- [ ] Application accessible via browser
- [ ] Login functionality working
- [ ] Database queries executing
- [ ] Logs show no errors
- [ ] Security settings configured
- [ ] Backups scheduled
