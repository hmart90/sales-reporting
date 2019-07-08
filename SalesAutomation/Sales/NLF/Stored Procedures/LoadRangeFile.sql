CREATE PROCEDURE [NLF].[LoadRangeFile]
	@Path as NVARCHAR(1000)
AS
	EXEC [NLF].GetRangeDates @Path
	EXEC [NLF].LoadRangeData @Path
	EXEC [NLF].AutoCreateNewItems @Path
	EXEC [NLF].MigrateRangeData @Path

	UPDATE dbo.FileLoad
	SET IsLoaded = 1
	WHERE Path = @Path AND IsLoaded = 0

RETURN 0
