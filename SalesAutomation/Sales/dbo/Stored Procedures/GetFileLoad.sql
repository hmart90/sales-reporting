CREATE PROCEDURE [dbo].[GetFileLoad]
AS
	SELECT TOP 1 Path, Name
	
	FROM dbo.FileLoad 
	
	WHERE  IsLoaded = 0

RETURN 0
