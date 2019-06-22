CREATE PROCEDURE MSTR.[LoadMSTRSalesFile]
	@Path as NVARCHAR(1000)
AS
	EXEC MSTR.GetMSTRFileDates @Path
	EXEC MSTR.LoadMSTRSalesData @Path
	EXEC MSTR.AutoCreateNewItemsFromMSTRSales @Path
	EXEC MSTR.MigrateMSTRSalesData @Path

	UPDATE dbo.FileLoad
	SET IsLoaded = 1
	WHERE Path = @Path

RETURN 0
