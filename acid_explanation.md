# ACID Property Explanation

## Transaction Used

Transaction Scenario 1:
Student Submission and Test Results

---

# Atomicity

Both INSERT operations are treated as a single unit.

If test-result insertion fails, the submission insertion also fails.

The transaction prevents partial data storage.

---

# Consistency

The transaction maintains valid relationships:

- submission_id exists
- testcase_id exists
- student_id exists

Database rules remain satisfied after COMMIT.

---

# Isolation

Other users cannot see incomplete transaction changes while execution is ongoing.

This prevents dirty reads and inconsistent query results.

---

# Durability

After COMMIT, inserted submission and test-result records are permanently stored.

Even if system crashes later, committed data remains saved.
