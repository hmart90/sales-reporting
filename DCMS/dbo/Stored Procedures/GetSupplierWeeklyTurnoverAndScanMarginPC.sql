-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSupplierWeeklyTurnoverAndScanMarginPC]
	@SupplierId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		SELECT [Fiscalweek]
			  ,sum([WeeklysumofSalesexclVAT]) as WeeklySalesExclVAT
			  ,sum([WeeklysumofScanmargin])/sum([WeeklysumofSalesexclVAT]) as WeeklyScarMarginPC

	  FROM [DCMS].[dbo].[WeeklyTurnover] as wt

	  INNER JOIN dbo.Supplier as s ON s.SupplierId = wt.SupplierId

	  WHERE s.SupplierId = @SupplierID

	  group by [Fiscalweek]

	  HAVING (sum([WeeklysumofSalesexclVAT]) != 0)

	  ORDER BY [Fiscalweek] asc


END
