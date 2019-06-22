CREATE PROCEDURE [dbo].[UpdateFileLoadToProcessed]
	@Path as NVARCHAR(1000)
AS

UPDATE dbo.FileLoad
SET IsLoaded = 1
WHERE [Path] = @Path AND IsLoaded = 0

RETURN 0
