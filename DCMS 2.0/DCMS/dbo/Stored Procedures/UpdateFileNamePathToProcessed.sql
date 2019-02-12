CREATE PROCEDURE [dbo].[UpdateFileNamePathToProcessed]
	@filenamepath as nvarchar(500)
AS
	UPDATE dbo.FileNamePath
	SET Processed = 1
	WHERE FilenamePath = @filenamepath

RETURN 0
