CREATE PROCEDURE [dbo].[GetTempFile]
	@type nvarchar(50),
	@salesorstock nvarchar(50)
AS
	SELECT TOP 1 FileNamePath, Filename
	
	FROM dbo.FileNamePath 
	
	WHERE  [Type] = @type
			AND SalesOrStock = @salesorstock
			AND Processed = 0

RETURN 0
