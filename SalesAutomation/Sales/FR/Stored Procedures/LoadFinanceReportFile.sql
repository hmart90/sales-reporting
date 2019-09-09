CREATE PROCEDURE [FR].[LoadFinanceReportFile]
	@Path as NVARCHAR(1000)
AS
	EXEC FR.GetFRFileDates @Path

	DECLARE @DateDiff INT;

	SET @DateDiff = (SELECT DATEDIFF(day,StartDate,EndDate) FROM dbo.FileLoad WHERE [Path] = @Path AND IsLoaded = 0);

	IF @DateDiff > 10

		BEGIN
			
			EXEC FR.LoadFRMonthlySales @Path;
			EXEC FR.MigrateFRMonthlySalesData @Path;
			EXEC FR.LoadFRMonthlyClosing @Path;
			EXEC FR.MigrateFRMonthlyClosingData @Path;
			
		END

	ELSE

		BEGIN

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

		END

	UPDATE dbo.FileLoad
	SET IsLoaded = 1
	WHERE Path = @Path

RETURN 0
