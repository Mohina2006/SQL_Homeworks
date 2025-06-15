DROP TABLE IF EXISTS worker;
CREATE TABLE worker (
    id INT,
    name VARCHAR(100)
);
BULK INSERT worker
FROM 'C:\Users\user\Desktop\SQL_Homeworks\lesson-2\homework\worker_data.csv'
WITH (
    FIELDTERMINATOR = ',',     
    ROWTERMINATOR = '\n',     
    FIRSTROW = 1              
);
SELECT * FROM worker;