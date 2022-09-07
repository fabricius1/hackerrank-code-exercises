-- The PADS
-- https://www.hackerrank.com/challenges/the-pads/problem?isFullScreen=true

-- CODE 1
SELECT Name + '(' + LEFT(Occupation, 1) + ')'
FROM OCCUPATIONS
ORDER BY 1;

SELECT 'There are a total of ' + STR(COUNT(Occupation)) + ' ' + LOWER(Occupation) + 's.'
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(Occupation);

-- CODE 2
SELECT CONCAT(Name, '(', LEFT(Occupation, 1), ')')
FROM OCCUPATIONS
ORDER BY 1;

SELECT CONCAT(
    'There are a total of ',
    CONVERT(COUNT(Occupation), NCHAR),
    ' ', 
    LOWER(Occupation), 
    's.'
) 
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(Occupation);

/*****************************************************/

-- Top Competitors
-- https://www.hackerrank.com/challenges/full-score/problem?isFullScreen=true

-- CODE 1
SELECT h.hacker_id, h.name
FROM Submissions s
JOIN Hackers h
ON h.hacker_id = s.hacker_id
JOIN Challenges c
ON c.challenge_id = s.challenge_id
JOIN Difficulty d
ON d.difficulty_level = c.difficulty_level
GROUP BY h.hacker_id, h.name
HAVING SUM(IIF(s.score = d.score, 1, 0)) >= 2
ORDER BY SUM(IIF(s.score = d.score, 1, 0)) DESC, 1;

-- CODE 2
SELECT h.hacker_id, h.name
FROM Submissions s
JOIN Hackers h
ON h.hacker_id = s.hacker_id
JOIN Challenges c
ON c.challenge_id = s.challenge_id
JOIN Difficulty d
ON d.difficulty_level = c.difficulty_level
GROUP BY h.hacker_id, h.name
HAVING SUM(
    CASE
        WHEN s.score = d.score then 1
        ELSE 0
    END) >= 2
ORDER BY SUM(
    CASE
        WHEN s.score = d.score then 1
        ELSE 0
    END) DESC, 1;

/*****************************************************/

-- The Report
-- https://www.hackerrank.com/challenges/the-report/problem?isFullScreen=true

-- CODE 1
SELECT
    IIF(Marks <= 69, NULL, Name),
    CASE
        WHEN Marks BETWEEN 0 AND 9 THEN 1
        WHEN Marks BETWEEN 10 AND 19 THEN 2
        WHEN Marks BETWEEN 20 AND 29 THEN 3
        WHEN Marks BETWEEN 30 AND 39 THEN 4
        WHEN Marks BETWEEN 40 AND 49 THEN 5
        WHEN Marks BETWEEN 50 AND 59 THEN 6
        WHEN Marks BETWEEN 60 AND 69 THEN 7
        WHEN Marks BETWEEN 70 AND 79 THEN 8
        WHEN Marks BETWEEN 80 AND 89 THEN 9
        WHEN Marks BETWEEN 90 AND 100 THEN 10
    END AS Grades,
    Marks
FROM STUDENTS
ORDER BY 2 DESC, 1

-- CODE 2
SELECT
    CASE
        WHEN Marks <= 69 THEN NULL
        ELSE Name
    END AS Masked_Names,
    CASE
        WHEN Marks BETWEEN 0 AND 9 THEN 1
        WHEN Marks BETWEEN 10 AND 19 THEN 2
        WHEN Marks BETWEEN 20 AND 29 THEN 3
        WHEN Marks BETWEEN 30 AND 39 THEN 4
        WHEN Marks BETWEEN 40 AND 49 THEN 5
        WHEN Marks BETWEEN 50 AND 59 THEN 6
        WHEN Marks BETWEEN 60 AND 69 THEN 7
        WHEN Marks BETWEEN 70 AND 79 THEN 8
        WHEN Marks BETWEEN 80 AND 89 THEN 9
        WHEN Marks BETWEEN 90 AND 100 THEN 10
    END AS Grades,
    Marks
FROM STUDENTS
ORDER BY 2 DESC, 1

/*****************************************************/
