.read fa19data.sql

CREATE TABLE obedience AS
  SELECT seven, instructor from students ;

CREATE TABLE smallest_int AS
    SELECT time, smallest
    FROM students
    WHERE smallest > 2
    ORDER BY smallest
    LIMIT 20;

CREATE TABLE matchmaker AS
    SELECT a.pet as pet, a.song as song, a.color, b.color
    FROM students as a, students as b
    WHERE a.pet = b.pet and a.song = b.song and a.time < b.time;