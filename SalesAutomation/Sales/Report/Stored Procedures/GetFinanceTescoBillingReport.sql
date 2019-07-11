CREATE PROCEDURE [Report].[GetFinanceTescoBillingReport]
	@StartDate DATE,
	@EndDate DATE
AS

SELECT 
		p.TPN
		,p.EAN
		,p.TitleHU as [Description]
      ,round(sum(s.[CostPrice]*s.[Number])/sum(s.[Number]),2) as CostPrice
      ,sum(s.[Number]) as SumSales
	  ,round(SUM(s.NetSales),2) as SumBrutSales

FROM [FR].[MonthlySales] as s
INNER JOIN dbo.Product as p on p.ProductId = s.ProductId


WHERE [EventDate] >= @StartDate AND [EventDate] <= @EndDate
		AND s.[Number] != 0

GROUP BY p.TPN
		,p.EAN
		,p.TitleHU
		,round(s.[CostPrice],0)

ORDER BY p.TPN asc,round(s.[CostPrice],0) asc


RETURN 0
