-- =====================================================
-- SAFE UPDATE OPERATIONS
-- =====================================================

-- Create staging tables

CREATE TABLE Staging_Students AS
SELECT *
FROM Students;

CREATE TABLE Staging_Submissions AS
SELECT *
FROM Submissions;

CREATE TABLE Staging_Regrade AS
SELECT *
FROM Regrade_Requests;


-- =====================================================
-- UPDATE 1: Correct Invalid Email
-- =====================================================

-- Before Update

SELECT student_id, email
FROM Staging_Students
WHERE email = 'rahulgmail.com';

-- Update Query

UPDATE Staging_Students
SET email = 'rahul@gmail.com'
WHERE student_id = 101
AND email = 'rahulgmail.com';

-- After Update

SELECT student_id, email
FROM Staging_Students
WHERE student_id = 101;

-- Safety Explanation:
-- WHERE clause uses both student_id and old email value,
-- ensuring only one intended row is modified.


-- =====================================================
-- UPDATE 2: Correct Missing Batch
-- =====================================================

-- Before Update

SELECT student_id, batch_id
FROM Staging_Students
WHERE batch_id IS NULL;

-- Update Query

UPDATE Staging_Students
SET batch_id = 3
WHERE student_id = 121
AND batch_id IS NULL;

-- After Update

SELECT student_id, batch_id
FROM Staging_Students
WHERE student_id = 121;

-- Safety Explanation:
-- WHERE clause prevents updates to valid batch records.


-- =====================================================
-- UPDATE 3: Correct Negative Score
-- =====================================================

-- Before Update

SELECT submission_id, score
FROM Staging_Submissions
WHERE score < 0;

-- Update Query

UPDATE Staging_Submissions
SET score = 0
WHERE submission_id = 5021
AND score < 0;

-- After Update

SELECT submission_id, score
FROM Staging_Submissions
WHERE submission_id = 5021;

-- Safety Explanation:
-- Only invalid negative score row is updated.


-- =====================================================
-- UPDATE 4: Update Submission Status
-- =====================================================

-- Before Update

SELECT submission_id, status
FROM Staging_Submissions
WHERE submission_id = 7001;

-- Update Query

UPDATE Staging_Submissions
SET status = 'Successful'
WHERE submission_id = 7001
AND score >= 90;

-- After Update

SELECT submission_id, status
FROM Staging_Submissions
WHERE submission_id = 7001;

-- Safety Explanation:
-- Status changes only if score satisfies validation rule.


-- =====================================================
-- UPDATE 5: Resolve Regrade Request
-- =====================================================

-- Before Update

SELECT request_id, request_status
FROM Staging_Regrade
WHERE request_id = 9001;

-- Update Query

UPDATE Staging_Regrade
SET request_status = 'Resolved'
WHERE request_id = 9001
AND request_status = 'Pending';

-- After Update

SELECT request_id, request_status
FROM Staging_Regrade
WHERE request_id = 9001;

-- Safety Explanation:
-- Prevents accidental updates to already resolved requests.
