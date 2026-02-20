# Oracle Database Migration - Quick Reference

## Summary of Changes

### 🗄️ Database Changes

| Item | MySQL | Oracle |
|------|-------|--------|
| **JDBC Driver** | `com.mysql.cj.jdbc.Driver` | `oracle.jdbc.driver.OracleDriver` |
| **Connection URL** | `jdbc:mysql://localhost:3306/skillgap_db` | `jdbc:oracle:thin:@localhost:1521:ORCL` |
| **Username** | `root` | `skillgap_user` |
| **ID Generation** | `INT AUTO_INCREMENT` | `NUMBER` + `SEQUENCE` |
| **Text Fields** | `VARCHAR(n)` | `VARCHAR2(n)` |
| **Large Text** | `TEXT` | `VARCHAR2(4000)` |
| **Decimal Numbers** | `DECIMAL(p,s)` | `NUMBER(p,s)` |
| **Currency** | `DECIMAL(10,2)` | `NUMBER(10,2)` |
| **Current Timestamp** | `CURRENT_TIMESTAMP` | `SYSDATE` |
| **Query Pattern** | Single multi-row INSERT | Individual INSERTs + COMMIT |

---

## 📝 Files Modified

### Core Database Files
1. ✅ `database/schema.sql` - 8 SEQUENCE definitions added
2. ✅ `database/sample_data.sql` - INSERT syntax updated
3. ✅ `database/important_queries.sql` - GROUP BY clauses updated

### Java Source Files
4. ✅ `backend/src/db/DBConnection.java` - JDBC driver updated

### Deployment Configuration
5. ✅ `deployment/tomcat-setup.md` - Oracle database section updated
6. ✅ `deployment/deployment_steps.md` - Oracle setup steps added
7. ✅ `README.md` - Technology stack updated

---

## 📚 New Documentation Created

1. ✨ `deployment/oracle-setup.md` - Complete Oracle setup guide
2. ✨ `deployment/ORACLE_MIGRATION.md` - Comprehensive migration guide
3. ✨ `deployment/ORACLE_DB_MIGRATION_SUMMARY.md` - Detailed summary

---

## 🚀 Quick Start Steps

### Step 1: Create Oracle User (as SYSDBA)
```sql
CREATE TABLESPACE skillgap_ts DATAFILE 'skillgap_ts.dbf' SIZE 100M;
CREATE USER skillgap_user IDENTIFIED BY password DEFAULT TABLESPACE skillgap_ts;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, UNLIMITED TABLESPACE TO skillgap_user;
```

### Step 2: Import Schema
```bash
sqlplus skillgap_user/password@ORCL
SQL> @database/schema.sql
SQL> @database/sample_data.sql
```

### Step 3: Configure Tomcat
```xml
<!-- In $CATALINA_HOME/conf/context.xml -->
<Resource name="jdbc/skillgap_db"
    driverClassName="oracle.jdbc.driver.OracleDriver"
    url="jdbc:oracle:thin:@localhost:1521:ORCL"
    username="skillgap_user"
    password="password" />
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

---

## ✔️ Verification Commands

### Check Tables
```sql
SELECT table_name FROM user_tables;
-- Should return: assessments, assessment_results, recommendations, skill_gap_analysis, skills, student_skills, students, users
```

### Check Sequences
```sql
SELECT sequence_name FROM user_sequences;
-- Should return: seq_assessments, seq_assessment_results, seq_recommendations, seq_skill_gap_analysis, seq_skills, seq_student_skills, seq_students, seq_users
```

### Count Data
```sql
SELECT COUNT(*) FROM users;           -- Should be 3
SELECT COUNT(*) FROM students;         -- Should be 3
SELECT COUNT(*) FROM skills;           -- Should be 8
SELECT COUNT(*) FROM student_skills;   -- Should be 9
SELECT COUNT(*) FROM assessments;      -- Should be 5
SELECT COUNT(*) FROM assessment_results; -- Should be 5
SELECT COUNT(*) FROM skill_gap_analysis; -- Should be 5
SELECT COUNT(*) FROM recommendations;  -- Should be 5
```

---

## 🔑 Key Differences

### INSERT Statements
```sql
-- MySQL
INSERT INTO users (username, email) VALUES ('john', 'john@example.com');

-- Oracle
INSERT INTO users (user_id, username, email) 
VALUES (seq_users.NEXTVAL, 'john', 'john@example.com');
COMMIT;
```

### Date Handling
```sql
-- MySQL
'2024-01-15'

-- Oracle
TO_DATE('2024-01-15', 'YYYY-MM-DD')
```

### GROUP BY Clause
```sql
-- Oracle requires all non-aggregated columns
GROUP BY s.student_id, s.first_name, s.last_name  -- Not just s.student_id
```

---

## 📦 Required JDBC JAR

| Oracle Version | JDBC JAR |
|---|---|
| 11g R2 | ojdbc6.jar |
| 12c | ojdbc7.jar |
| 18c+ | ojdbc8.jar |
| 19c+ | ojdbc10.jar |

**Download:** https://www.oracle.com/database/technologies/appdev/jdbc.html

**Location:** `$CATALINA_HOME/lib/ojdbc8.jar`

---

## 🔍 Connection String Formats

```
# Standard (SID)
jdbc:oracle:thin:@localhost:1521:ORCL

# Service Name
jdbc:oracle:thin:@localhost:1521/SERVICE_NAME

# Extended
jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=ORCL)))

# RAC
jdbc:oracle:thin:@(DESCRIPTION=(LOAD_BALANCE=yes)(ADDRESS=(PROTOCOL=TCP)(HOST=host1)(PORT=1521))(ADDRESS=(PROTOCOL=TCP)(HOST=host2)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=service_name)))
```

---

## ⚠️ Common Issues & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| `ORA-12514 TNS:listener does not currently know of service requested` | Wrong SID | Check ORCL SID in connection string |
| `ORA-01017 invalid username/password` | Wrong credentials | Verify user and password |
| `ClassNotFoundException: oracle.jdbc.driver.OracleDriver` | Missing JDBC JAR | Place ojdbc8.jar in Tomcat lib |
| `ORA-00972 identifier is too long` | Column name > 30 chars | Shorten identifier names |
| `java.sql.SQLException: Connection refused` | Listener not running | Start Oracle listener: `lsnrctl start` |

---

## 📋 Pre-Deployment Checklist

- [ ] Oracle Database 11g R2+ installed
- [ ] Oracle listener running (port 1521)
- [ ] Tablespace skillgap_ts created
- [ ] User skillgap_user created with privileges
- [ ] schema.sql executed without errors
- [ ] sample_data.sql executed without errors
- [ ] All 8 tables verified with data
- [ ] All 8 sequences verified
- [ ] ojdbc8.jar downloaded
- [ ] ojdbc8.jar placed in $CATALINA_HOME/lib/
- [ ] Tomcat context.xml updated
- [ ] Tomcat restarted
- [ ] Application login page accessible
- [ ] Dashboard loads student data
- [ ] Database queries execute without errors

---

## 📞 Support Resources

1. **Oracle Docs:** https://docs.oracle.com/en/database/
2. **JDBC Guide:** https://docs.oracle.com/en/database/oracle/oracle-database/21/jjdbc/
3. **SQL*Plus:** https://docs.oracle.com/en/database/oracle/sql-plus/
4. **This Project Migration Guide:** `deployment/ORACLE_MIGRATION.md`
5. **Oracle Setup Details:** `deployment/oracle-setup.md`

---

## 📊 Data Summary

| Table | Rows | Sequences |
|-------|------|-----------|
| users | 3 | seq_users |
| students | 3 | seq_students |
| skills | 8 | seq_skills |
| student_skills | 9 | seq_student_skills |
| assessments | 5 | seq_assessments |
| assessment_results | 5 | seq_assessment_results |
| skill_gap_analysis | 5 | seq_skill_gap_analysis |
| recommendations | 5 | seq_recommendations |
| **TOTAL** | **43** | **8** |

---

## ✨ What's New

- ✅ 8 Oracle SEQUENCE objects for auto-incrementing IDs
- ✅ Oracle-optimized schema with VARCHAR2 and NUMBER types
- ✅ Comprehensive Oracle setup guide
- ✅ Complete migration documentation
- ✅ Oracle-specific troubleshooting section
- ✅ JDBC driver configuration guide
- ✅ SQL*Plus quick reference

---

**Status:** ✅ Ready for Oracle Deployment
**Last Updated:** February 18, 2026
**Compatibility:** Oracle 11g R2 and higher
**Tomcat Version:** 9.0+
