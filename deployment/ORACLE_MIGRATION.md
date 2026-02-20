# Oracle Database Migration Guide

## Overview
This guide documents the migration from MySQL to Oracle Database for the AI Skill Gap Analysis System.

## Key Changes

### 1. JDBC Driver
- **Old**: `com.mysql.cj.jdbc.Driver`
- **New**: `oracle.jdbc.driver.OracleDriver`

### 2. Connection String
- **Old**: `jdbc:mysql://localhost:3306/skillgap_db`
- **New**: `jdbc:oracle:thin:@localhost:1521:ORCL`

### 3. Database Files

#### Data Types Changes
| MySQL | Oracle |
|-------|--------|
| INT | NUMBER |
| VARCHAR(n) | VARCHAR2(n) |
| DECIMAL(p,s) | NUMBER(p,s) |
| TEXT | VARCHAR2(4000) or CLOB |
| TIMESTAMP | TIMESTAMP |
| AUTO_INCREMENT | SEQUENCE + TRIGGER (or use NEXTVAL in INSERT) |

#### Example Schema Changes
```sql
-- MySQL
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100),
    ...
);

-- Oracle
CREATE SEQUENCE seq_users START WITH 1 INCREMENT BY 1;

CREATE TABLE users (
    user_id NUMBER PRIMARY KEY,
    username VARCHAR2(100),
    ...
);
```

### 4. Data Insertion Changes

**MySQL Pattern**:
```sql
INSERT INTO users (username, email) VALUES ('john', 'john@example.com');
```

**Oracle Pattern**:
```sql
INSERT INTO users (user_id, username, email) 
VALUES (seq_users.NEXTVAL, 'john', 'john@example.com');
```

### 5. Date/Time Functions

| MySQL | Oracle |
|-------|--------|
| CURRENT_TIMESTAMP | SYSDATE or SYSTIMESTAMP |
| CURDATE() | TRUNC(SYSDATE) |
| CURTIME() | TRUNC(SYSTIMESTAMP) |
| DATE_ADD() | ADD_MONTHS() |
| DATE_FORMAT() | TO_CHAR() |

### 6. String Functions

| MySQL | Oracle |
|-------|--------|
| CONCAT() | \|\| operator or CONCAT() |
| SUBSTRING() | SUBSTR() |
| INSTR() | INSTR() (similar) |
| LENGTH() | LENGTH() (similar) |
| UPPER() | UPPER() (similar) |
| LOWER() | LOWER() (similar) |

## Configuration Files Updated

### 1. DBConnection.java
- Updated JDBC driver class
- Updated connection URL
- Updated credentials (using Oracle user: skillgap_user)

### 2. schema.sql
- Converted all AUTO_INCREMENT to SEQUENCE
- Changed VARCHAR to VARCHAR2
- Changed TEXT to VARCHAR2(4000)
- Changed DECIMAL to NUMBER
- Changed TIMESTAMP DEFAULT CURRENT_TIMESTAMP to TIMESTAMP DEFAULT SYSDATE
- Removed ON DELETE CASCADE (added as constraint definition)

### 3. sample_data.sql
- Updated INSERT statements to use sequence NEXTVAL
- Changed date format to use TO_DATE()
- Added COMMIT statements after each batch of inserts

### 4. important_queries.sql
- No major changes needed for SELECT queries
- Oracle supports standard SQL syntax
- Updated GROUP BY clauses to include all non-aggregated columns (Oracle requirement)

### 5. Deployment Documentation
- Updated Tomcat context.xml configuration
- Updated connection pool settings for Oracle
- Added Oracle tablespace creation steps
- Added Oracle user creation steps

## Pre-Deployment Checklist

- [ ] Oracle Database installed and running
- [ ] Oracle listener running on port 1521
- [ ] Tablespace created (skillgap_ts)
- [ ] Database user created (skillgap_user)
- [ ] User privileges granted
- [ ] JDBC driver (ojdbc8.jar) downloaded
- [ ] JDBC driver placed in $CATALINA_HOME/lib/
- [ ] schema.sql executed successfully
- [ ] sample_data.sql executed successfully
- [ ] All tables created verified
- [ ] All sequences created verified

## Deployment Steps

### Step 1: Oracle Database Preparation
```bash
sqlplus / as sysdba
SQL> @/path/to/setup_tablespace.sql
SQL> CREATE USER skillgap_user IDENTIFIED BY password;
SQL> GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE TO skillgap_user;
```

### Step 2: Execute Schema
```bash
sqlplus skillgap_user/password@ORCL
SQL> @/path/to/database/schema.sql
SQL> @/path/to/database/sample_data.sql
```

### Step 3: Configure Tomcat
```xml
<!-- Update $CATALINA_HOME/conf/context.xml -->
<Resource name="jdbc/skillgap_db" 
    auth="Container"
    type="javax.sql.DataSource"
    driverClassName="oracle.jdbc.driver.OracleDriver"
    url="jdbc:oracle:thin:@localhost:1521:ORCL"
    username="skillgap_user"
    password="password"
    maxActive="50" maxIdle="10" />
```

### Step 4: Copy JDBC Driver
```bash
cp ojdbc8.jar $CATALINA_HOME/lib/
```

### Step 5: Restart Tomcat
```bash
$CATALINA_HOME/bin/shutdown.sh
$CATALINA_HOME/bin/startup.sh
```

## Verification

### Check Database Connectivity
```bash
sqlplus skillgap_user/password@ORCL
SQL> SELECT COUNT(*) FROM users;
SQL> SELECT COUNT(*) FROM students;
SQL> SELECT COUNT(*) FROM skills;
```

### Check Tomcat Logs
```bash
tail -f $CATALINA_HOME/logs/catalina.out
```

## Rollback Plan

If issues occur during migration:

1. **Keep MySQL Database Running**: Don't drop tables until Oracle is verified
2. **Restore Previous Configuration**: Revert Tomcat context.xml to MySQL settings
3. **Rebuild from MySQL**: Use MySQL backup to recover if needed

## Performance Considerations

### Oracle-Specific Optimizations

1. **Query Optimization**
```sql
-- Oracle optimizer hints for complex queries
SELECT /*+ FIRST_ROWS(10) */ * FROM large_table WHERE condition;
```

2. **Index Creation**
```sql
CREATE INDEX idx_student_user ON students(user_id);
CREATE INDEX idx_skill_name ON skills(skill_name);
```

3. **Statistics Update**
```sql
ANALYZE TABLE users COMPUTE STATISTICS;
EXEC DBMS_STATS.GATHER_TABLE_STATS('skillgap_user', 'users');
```

4. **Query Execution Plan**
```sql
EXPLAIN PLAN FOR SELECT * FROM students WHERE user_id = 1;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
```

## Troubleshooting

### Issue: ORA-12514 TNS:listener does not currently know of service requested
**Solution**: Check SID in connection string matches installed database

### Issue: ORA-00972 identifier is too long
**Solution**: Oracle has 30-character limit for identifiers; shorten names if needed

### Issue: java.sql.SQLException: Invalid column index
**Solution**: Verify column order in INSERT statements matches table definition

### Issue: Connection pool exhausted
**Solution**: Increase `maxActive` in context.xml or optimize query performance

## References

- [Oracle Setup Documentation](oracle-setup.md)
- [Deployment Steps](deployment_steps.md)
- [Tomcat Setup Guide](tomcat-setup.md)

## Support

For issues or questions regarding Oracle database migration, refer to:
- Oracle Official Documentation: https://docs.oracle.com/
- JDBC Configuration: Check `$CATALINA_HOME/conf/context.xml`
- Application Logs: `$CATALINA_HOME/logs/catalina.out`
