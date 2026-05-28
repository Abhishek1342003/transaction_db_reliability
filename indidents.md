# Reliability Incident Note

## Incident Description

A developer accidentally executed:

```sql
UPDATE Submissions
SET status = 'Successful';
```

without using a WHERE clause.

---

# What Went Wrong

The query updated every submission record in the database.

Failed and pending submissions were incorrectly marked as successful.

---

# Data Affected

Affected tables:

- Submissions
- Analytics reports
- Contest rankings
- Student performance metrics

Incorrect statuses could also affect regrade requests and plagiarism analysis.

---

# Detection Method

The issue could be detected by:

- Sudden increase in successful submission counts
- Audit logs
- Unexpected leaderboard changes
- Transaction monitoring

---

# Recovery Method

If wrapped inside a transaction:

```sql
ROLLBACK;
```

could immediately undo the operation.

Otherwise:

- Restore from backup
- Use binary logs
- Use point-in-time recovery

---

# Preventive Measures

- Always use WHERE clauses
- Use staging tables for testing
- Run SELECT before UPDATE/DELETE
- Use transactions during modifications
- Enable backup and recovery systems
- Use role-based access control
