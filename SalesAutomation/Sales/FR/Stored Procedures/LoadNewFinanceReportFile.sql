CREATE PROCEDURE [FR].[LoadNewFinanceReportFile]
	@Path as NVARCHAR(1000)
AS
	EXEC FR.GetFRNewFileDates @Path
			
	EXEC FR.LoadFRNewRR @Path;
	EXEC FR.LoadFRNewSales @Path;
	EXEC FR.MigrateFRNewSalesData @Path;
	EXEC FR.LoadFRNewStock @Path;
	EXEC FR.MigrateFRNewStockData @Path;
			
	UPDATE dbo.FileLoad
	SET IsLoaded = 1
	WHERE Path = @Path

RETURN 0
