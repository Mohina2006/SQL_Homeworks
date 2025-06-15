-- 1. Drop table if it exists
DROP TABLE IF EXISTS student;
GO

-- 2. Create table
CREATE TABLE student (
	id INT IDENTITY PRIMARY KEY,
	name VARCHAR(50),
	student_classes INT,
	tuition_per_class INT,
	total_tuition AS (student_classes * tuition_per_class)
);
GO

-- 3. Insert sample data
INSERT INTO student(name, student_classes, tuition_per_class)
VALUES 
 ('Alice', 4, 500),
 ('Bob', 6, 700),
 ('Charlie', 3, 800);
GO

-- 4. Select data
SELECT * FROM student;
