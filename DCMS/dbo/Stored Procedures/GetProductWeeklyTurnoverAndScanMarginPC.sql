-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProductWeeklyTurnoverAndScanMarginPC]
	@ProductId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT 
      p.[LocalTPNitemLongdescription]
      ,[Fiscalweek]
      ,[WeeklysumofSalesexclVAT]
	  ,[WeeklysumofScanmargin] / [WeeklysumofSalesexclVAT] as WeeklyScanMarginPC
  FROM [DCMS].[dbo].[WeeklyTurnover] as wt

  INNER JOIN dbo.Product as p on p.[ProductId] = wt.[ProductId]

  WHERE wt.[ProductId] = @ProductId
		AND [Weeklysumofsoldunits] != 0

	ORDER BY [Fiscalweek] asc

END
