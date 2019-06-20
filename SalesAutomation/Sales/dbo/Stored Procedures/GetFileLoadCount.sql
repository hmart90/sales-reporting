CREATE PROCEDURE [dbo].[GetFileLoadCount]

AS
	DECLARE @countoftempfile INT = 
		(
			SELECT count(Path)
			FROM dbo.FileLoad
			WHERE  IsLoaded = 0
			)

	SELECT (CASE WHEN @countoftempfile > 0 THEN 1 ELSE 0 END) AS TempFileCount

RETURN 0
