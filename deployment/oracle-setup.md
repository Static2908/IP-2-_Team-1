# Oracle Database Setup and Configuration Guide

## Oracle Database Installation

### Prerequisites
- Oracle Database 11g R2 or higher
- 2GB RAM minimum
- 6GB disk space
- Administrator privileges

## Create Tablespace and User

### Step 1: Connect as SYSDBA
```bash
sqlplus / as sysdba
```

### Step 2: Create Tablespace
```sql
CREATE TABLESPACE skillgap_ts 
  DATAFILE 'skillgap_ts.dbf' SIZE 100M AUTOEXTEND ON NEXT 50M 
  EXTENT MANAGEMENT LOCAL AUTOALLOCATE;
```

### Step 3: Create Database User
```sql
CREATE USER skillgap_user IDENTIFIED BY your_secure_password
  DEFAULT TABLESPACE skillgap_ts
  TEMPORARY TABLESPACE temp
  QUOTA UNLIMITED ON skillgap_ts;
```

### Step 4: Grant Privileges
```sql
GRANT CREATE SESSION TO skillgap_user;
GRANT CREATE TABLE TO skillgap_user;
GRANT CREATE SEQUENCE TO skillgap_user;
GRANT CREATE INDEX TO skillgap_user;
GRANT CREATE VIEW TO skillgap_user;
GRANT CREATE TRIGGER TO skillgap_user;
GRANT UNLIMITED TABLESPACE TO skillgap_user;
```

## Import Database Schema

### Method 1: Using SQL*Plus
```bash
sqlplus skillgap_user/your_password@ORCL
SQL> @/path/to/schema.sql
SQL> @/path/to/sample_data.sql
SQL> EXIT;
```

### Method 2: Using SQL Developer
1. Open SQL Developer
2. Create new connection for skillgap_user
3. Open schema.sql file
4. Execute the script
5. Repeat for sample_data.sql

## Verify Installation

### Check Tables Created
```sql
SELECT table_name FROM user_tables;
```

### Check Sequences Created
```sql
SELECT sequence_name FROM user_sequences;
```

### Check Data Inserted
```sql
SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM students;
SELECT COUNT(*) FROM skills;
```

## Oracle JDBC Driver Configuration

### Step 1: Download JDBC Driver
- Oracle Database 11g: Download `ojdbc6.jar`
- Oracle Database 12c+: Download `ojdbc8.jar`
- Oracle Database 19c+: Download `ojdbc10.jar`

Download from: https://www.oracle.com/database/technologies/appdev/jdbc.html

### Step 2: Place Driver in Tomcat
Copy the JDBC driver to:
```
$CATALINA_HOME/lib/ojdbc8.jar
```

### Step 3: Update Connection String
```properties
# For Oracle Database with SID (System Identifier)
jdbc:oracle:thin:@localhost:1521:ORCL

# For Oracle Database with Service Name
jdbc:oracle:thin:@localhost:1521/SERVICE_NAME

# For RAC (Real Application Clusters)
jdbc:oracle:thin:@(DESCRIPTION=(LOAD_BALANCE=yes)(ADDRESS=(PROTOCOL=TCP)(HOST=host1)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=host2)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=service_name)))
```

## Connection String Components

| Component | Description | Example |
|-----------|-------------|---------|
| `localhost` | Oracle server hostname/IP | 192.168.1.100 |
| `1521` | Oracle listener port | 1521 (default) |
| `ORCL` | SID or Service Name | XE, ORCL, PROD |

## Troubleshooting

### Connection Refused
- Verify Oracle listener is running: `lsnrctl status`
- Check firewall permissions for port 1521
- Verify ORACLE_HOME environment variable is set

### Invalid User Name and Password
```bash
sqlplus skillgap_user/your_password@ORCL
```
If failed, reset password:
```sql
ALTER USER skillgap_user IDENTIFIED BY new_password;
```

### Table Not Found
- Verify you're connected as skillgap_user
- Use `DESC tablename;` to verify table exists
- Check syntax in schema.sql file

### Sequence Not Found
- Verify sequences were created: `SELECT * FROM user_sequences;`
- Check sequence names in INSERT statements
- Use `NEXTVAL` to increment sequence

### JDBC Driver Not Found
- Verify ojdbc jar file is in `$CATALINA_HOME/lib/`
- Restart Tomcat after adding driver
- Check Java class path in Tomcat startup logs

## Database Maintenance

### Backup Database
```bash
# Full backup using RMAN
rman target sys/password@ORCL
RMAN> BACKUP DATABASE PLUS ARCHIVELOG;

# Export specific user data
expdp skillgap_user/password SCHEMAS=skillgap_user DIRECTORY=data_pump_dir DUMPFILE=skillgap_backup.dmp
```

### Restore Database
```bash
# Import specific user data
impdp skillgap_user/password SCHEMAS=skillgap_user DIRECTORY=data_pump_dir DUMPFILE=skillgap_backup.dmp
```

### Monitor Database Performance
```sql
-- Check database size
SELECT SUM(bytes)/1024/1024/1024 AS size_gb FROM dba_data_files;

-- Check tablespace usage
SELECT tablespace_name, SUM(bytes)/1024/1024 AS size_mb 
FROM dba_free_space 
GROUP BY tablespace_name;

-- Check active sessions
SELECT COUNT(*) FROM v$session WHERE status='ACTIVE';
```

## Performance Tuning

### Connection Pool Settings (Tomcat)
```xml
<Resource 
    name="jdbc/skillgap_db" 
    type="javax.sql.DataSource"
    maxActive="50"          <!-- Max connections -->
    maxIdle="10"            <!-- Max idle connections -->
    maxWait="30000"         <!-- Max wait time in ms -->
    initialSize="10"        <!-- Initial pool size -->
    validationQuery="SELECT 1 FROM DUAL"
    validationInterval="30000"
    testOnBorrow="true"
    testOnReturn="true" />
```

### Index Creation for Better Performance
```sql
-- Create indexes on frequently queried columns
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_student_user ON students(user_id);
CREATE INDEX idx_student_skills_student ON student_skills(student_id);
CREATE INDEX idx_assessment_student ON assessment_results(student_id);
```

## Security Best Practices

### 1. Use Strong Passwords
```sql
ALTER USER skillgap_user IDENTIFIED BY "Str0ng!Password#2024";
```

### 2. Restrict User Privileges
```sql
-- Grant minimum required privileges
REVOKE UNLIMITED TABLESPACE FROM skillgap_user;
GRANT QUOTA 500M ON skillgap_ts TO skillgap_user;
```

### 3. Create Read-Only User (Optional)
```sql
CREATE USER skillgap_readonly IDENTIFIED BY readonly_password;
GRANT CREATE SESSION TO skillgap_readonly;
GRANT SELECT ON skillgap_user.users TO skillgap_readonly;
GRANT SELECT ON skillgap_user.students TO skillgap_readonly;
GRANT SELECT ON skillgap_user.skills TO skillgap_readonly;
-- Grant SELECT on all other tables similarly
```

### 4. Enable Audit Logging
```sql
AUDIT SELECT ON skillgap_user.users;
AUDIT INSERT, UPDATE, DELETE ON skillgap_user.users;
```

## Oracle SQL*Plus Commands Reference

```bash
# Connect to database
sqlplus skillgap_user/password@ORCL

# Inside SQL*Plus
DESC tablename;                    -- Describe table structure
SELECT * FROM user_tables;         -- List all tables
SELECT COUNT(*) FROM tablename;    -- Count rows
@/path/to/script.sql              -- Execute SQL script
EXIT;                             -- Exit SQL*Plus
```

## Connection Testing

### Test Connection with Java
```java
import java.sql.*;

public class OracleConnectionTest {
    public static void main(String[] args) {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:ORCL",
                "skillgap_user",
                "password"
            );
            System.out.println("Oracle database connection successful!");
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

## Additional Resources

- [Oracle Documentation](https://docs.oracle.com/en/database/)
- [Oracle JDBC Documentation](https://docs.oracle.com/en/database/oracle/oracle-database/19/jjdbc/)
- [SQL*Plus User Guide](https://docs.oracle.com/en/database/oracle/sql-plus/)
