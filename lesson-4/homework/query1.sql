DROP TABLE IF EXISTS [dbo].[TestMultipleZero]
CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);
select * from [dbo].[TestMultipleZero] where 
isnull(A, 0) + isnull(B, 0) + isnull(C, 0) + isnull(D, 0) > 0;