-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSuppliersProductsStats]
	@SupplierID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
	  p.[LocalTPNitemTPN]
      ,p.[LocalTPNitemLongdescription]
      ,sum([Weeklysumofsoldunits]) as TotalSoldUnits
      ,sum([WeeklysumofSalesexclVAT]) as TotalSalesexclVAT
      ,sum([WeeklysumofScanmargin]) as TotalScanMargin
	  ,(CASE WHEN sum([Weeklysumofsoldunits]) != 0
				THEN sum([WeeklysumofSalesexclVAT])/sum([Weeklysumofsoldunits])
				ELSE 0
		END) as AveragePrice
	  ,(CASE WHEN sum([Weeklysumofsoldunits]) != 0
				THEN sum([WeeklysumofScanmargin])/sum([Weeklysumofsoldunits])
				ELSE 0
		END) as AverageUnitScanMargin
		,min((CASE WHEN [Weeklysumofsoldunits] != 0 THEN [WeeklysumofScanmargin]/[Weeklysumofsoldunits] ELSE 1000000 END)) as MinUnitScanMargin
		,max((CASE WHEN [Weeklysumofsoldunits] != 0 THEN [WeeklysumofScanmargin]/[Weeklysumofsoldunits] ELSE -1000000 END)) as MaxUnitScanMargin

  FROM [DCMS].[dbo].[WeeklyTurnover] as wt

  INNER JOIN dbo.Product as p ON p.ProductId = wt.ProductId

  WHERE wt.SupplierID = @SupplierID

  GROUP BY 
	  p.[LocalTPNitemTPN]
      ,p.[LocalTPNitemLongdescription]

END
