CREATE PROCEDURE MSTR.[LoadMSTRStockFile]
	@Path as NVARCHAR(1000)
AS
	EXEC MSTR.GetMSTRFileDates @Path
	EXEC MSTR.LoadMSTRStockData @Path
	EXEC MSTR.AutoCreateNewItemsFromMSTRStock @Path
	EXEC MSTR.MigrateMSTRStockData @Path

	UPDATE dbo.FileLoad
	SET IsLoaded = 1
	WHERE Path = @Path AND IsLoaded = 0

RETURN 0
