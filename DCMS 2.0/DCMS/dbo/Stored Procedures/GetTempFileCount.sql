CREATE PROCEDURE [dbo].[GetTempFileCount]
	@type nvarchar(50),
	@salesorstock nvarchar(50)
AS
	declare @countoftempfile int = (SELECT count(FileNamePath)
	
	FROM dbo.FileNamePath 
	
	WHERE  [Type] = @type
			AND SalesOrStock = @salesorstock
			AND Processed = 0)

	SELECT (CASE WHEN @countoftempfile > 0 THEN 1 ELSE 0 END) AS TempFileCount

RETURN 0
