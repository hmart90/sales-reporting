CREATE PROCEDURE [FR].[LoadFinanceReportFile]
	@Path as NVARCHAR(1000)
AS
	EXEC FR.GetFRFileDates @Path
	EXEC FR.LoadFROpening @Path
	EXEC FR.LoadFRClosing @Path
	EXEC FR.LoadFRSales @Path
	EXEC FR.AutoCreateNewItemsFromFR @Path
	EXEC FR.MigrateFROpeningData @Path
	EXEC FR.LoadFRLoading @Path
	EXEC FR.MigrateFRLoadingData @Path
	EXEC FR.MigrateFRClosingData @Path
	EXEC FR.LoadFRMoving @Path
	EXEC FR.MigrateFRMovingData @Path
	EXEC FR.LoadFRReturn @Path
	EXEC FR.MigrateFRReturnData @Path
	EXEC FR.MigrateFRSalesData @Path
	EXEC FR.LoadFRRevaluate @Path
	EXEC FR.MigrateFRRevaluateData @Path

	UPDATE dbo.FileLoad
	SET IsLoaded = 1
	WHERE Path = @Path

RETURN 0
