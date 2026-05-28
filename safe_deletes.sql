-- =====================================================
-- SAFE DELETE OPERATIONS
-- =====================================================

CREATE TABLE Staging_Enrollments AS
SELECT *
FROM Enrollments;

CREATE TABLE Staging_TestCases AS
SELECT *
FROM TestCases;


-- =====================================================
-- DELETE 1: Remove Duplicate Enrollment
-- =====================================================

-- Before Delete

SELECT student_id, course_id, COUNT(*)
FROM Staging_Enrollments
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

-- Delete Query

DELETE FROM Staging_Enrollments
WHERE enrollment_id = 4011;

-- After Delete

SELECT student_id, course_id, COUNT(*)
FROM Staging_Enrollments
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

-- Safety Explanation:
-- DELETE targets one known duplicate enrollment ID only.


-- =====================================================
-- DELETE 2: Remove Orphan Testcase
-- =====================================================

-- Before Delete

SELECT testcase_id
FROM Staging_TestCases
WHERE problem_id NOT IN (
    SELECT problem_id
    FROM Problems
);

-- Delete Query

DELETE FROM Staging_TestCases
WHERE testcase_id = 803;

-- After Delete

SELECT testcase_id
FROM Staging_TestCases
WHERE testcase_id = 803;

-- Safety Explanation:
-- Only orphan testcase record is deleted after validation.


-- =====================================================
-- DELETE 3: Remove Dummy Test Record
-- =====================================================

-- Before Delete

SELECT *
FROM Staging_Students
WHERE name = 'TEST_USER';

-- Delete Query

DELETE FROM Staging_Students
WHERE student_id = 9999
AND name = 'TEST_USER';

-- After Delete

SELECT *
FROM Staging_Students
WHERE student_id = 9999;

-- Safety Explanation:
-- WHERE clause ensures only dummy testing record is removed.
