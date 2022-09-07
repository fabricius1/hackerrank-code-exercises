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

