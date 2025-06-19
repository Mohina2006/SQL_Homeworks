drop table if exists letters
create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');
SELECT *
FROM letters
ORDER BY 
    CASE WHEN letter = 'b' THEN 0 ELSE 1 END,  -- 'b' first
    letter;
-- ===========================================================
SELECT *
FROM letters
ORDER BY
    CASE WHEN letter = 'b' THEN 1 ELSE 0 END, letter; -- 'b' last
-- ===========================================================
WITH Ordered AS (
    SELECT letter, 
           ROW_NUMBER() OVER (ORDER BY letter) AS rn
    FROM letters
    WHERE letter <> 'b'
),
InsertedB AS (
    SELECT * FROM Ordered WHERE rn < 3

    UNION ALL

    SELECT 'b', 3  -- force b into 3rd position

    UNION ALL

    SELECT * FROM Ordered WHERE rn >= 3
)
SELECT letter
FROM InsertedB
ORDER BY rn;
