-- =====================================================
-- TRANSACTION SCENARIO 1
-- Student Submission and Test Results
-- =====================================================

START TRANSACTION;

INSERT INTO Submissions (
    submission_id,
    student_id,
    problem_id,
    score,
    status
)
VALUES (
    8101,
    101,
    201,
    95,
    'Successful'
);

INSERT INTO Test_Results (
    result_id,
    submission_id,
    testcase_id,
    result_status
)
VALUES (
    9901,
    8101,
    501,
    'Passed'
);

COMMIT;

-- Expected Result:
-- Submission and test-result rows permanently stored.


-- =====================================================
-- TRANSACTION SCENARIO 2
-- Enrollment Rollback Example
-- =====================================================

START TRANSACTION;

INSERT INTO Enrollments (
    enrollment_id,
    student_id,
    course_id
)
VALUES (
    7001,
    999,
    20
);

-- Validation Failed:
-- student_id 999 does not exist

ROLLBACK;

-- Expected Result:
-- Enrollment record is not saved.


-- =====================================================
-- TRANSACTION SCENARIO 3
-- SAVEPOINT Example
-- =====================================================

START TRANSACTION;

UPDATE Submissions
SET score = 85
WHERE submission_id = 5101;

SAVEPOINT score_updated;

UPDATE Submissions
SET status = 'Successful'
WHERE submission_id = 5101;

-- Validation found incorrect status update

ROLLBACK TO score_updated;

COMMIT;

-- Expected Result:
-- Score update remains.
-- Status update rolled back.


-- =====================================================
-- TRANSACTION SCENARIO 4
-- Regrade Resolution
-- =====================================================

START TRANSACTION;

UPDATE Regrade_Requests
SET request_status = 'Resolved'
WHERE request_id = 9001;

UPDATE Submissions
SET score = 92
WHERE submission_id = 5105;

COMMIT;

-- Expected Result:
-- Both regrade resolution and score update saved together.
