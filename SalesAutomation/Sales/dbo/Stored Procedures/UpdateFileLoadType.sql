CREATE PROCEDURE [dbo].[UpdateFileLoadType]
	@Path as NVARCHAR(1000),
	@Type as NVARCHAR(100)
AS

DECLARE @NewName AS NVARCHAR(1000);
SET @NewName = @Type + '_' +  REPLACE(REPLACE(convert(varchar, getdate(), 126),'.','_'),':','') + '.xlsx'

UPDATE dbo.FileLoad
SET [NewName] = @NewName
	,[Type] = @Type
WHERE [Path] = @Path

SELECT @NewName AS NewFileName

RETURN 0
