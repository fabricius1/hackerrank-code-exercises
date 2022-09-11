/*
** SQL CODE ANSWERS 
** 
** DIFFICULT LEVEL: MEDIUM
*/

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
ORDER BY 2 DESC, 1;

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
ORDER BY 2 DESC, 1;

/*****************************************************/

-- Weather Observation Station 18 (Manhattan distance)
-- https://www.hackerrank.com/challenges/weather-observation-station-18/problem?isFullScreen=true

-- CODE 1
SELECT FORMAT(ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MIN(LONG_W) - MAX(LONG_W)), '.####')
FROM STATION;

-- CODE 2
SELECT ROUND(ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MIN(LONG_W) - MAX(LONG_W)), 4)
FROM STATION;

/*****************************************************/

-- Weather Observation Station 19 (euclidian distance)
-- https://www.hackerrank.com/challenges/weather-observation-station-19/problem?isFullScreen=true

-- CODE 1
SELECT FORMAT(SQRT(SQUARE(MAX(LAT_N) - MIN(LAT_N)) + SQUARE(MAX(LONG_W) - MIN(LONG_W))), '.####')
FROM STATION;

-- CODE 2
SELECT ROUND(SQRT(POWER(MAX(LAT_N) - MIN(LAT_N), 2) + POWER(MAX(LONG_W) - MIN(LONG_W), 2)), 4)
FROM STATION;

/*****************************************************/

-- Weather Observation Station 20 (calculate median)
-- https://www.hackerrank.com/challenges/weather-observation-station-20/problem?isFullScreen=true

-- CODE 1
-- (from https://stackoverflow.com/questions/1342898/function-to-calculate-median-in-sql-server/2026609#2026609)
SELECT FORMAT((
(SELECT MAX(LAT_N) FROM
    (SELECT TOP 50 PERCENT LAT_N FROM STATION ORDER BY LAT_N) AS t1)
    +
(SELECT MIN(LAT_N) FROM
    (SELECT TOP 50 PERCENT LAT_N FROM STATION ORDER BY LAT_N DESC) AS t2)
) / 2, '.####');

-- CODE 2
-- (from https://stackoverflow.com/a/7263925)
SELECT ROUND(AVG(dd.LAT_N), 4) as median_val
FROM (
SELECT s.LAT_N, @rownum:=@rownum+1 as `row_number`, @total_rows:=@rownum
  FROM STATION s, (SELECT @rownum:=0) r
  WHERE s.LAT_N is NOT NULL
  ORDER BY s.LAT_N
) as dd
WHERE dd.row_number IN ( FLOOR((@total_rows+1)/2), FLOOR((@total_rows+2)/2) );

/*****************************************************/
