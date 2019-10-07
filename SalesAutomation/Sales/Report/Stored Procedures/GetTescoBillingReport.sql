CREATE PROCEDURE [Report].[GetTescoBillingReport]
	@StartDate DATE,
	@EndDate DATE
AS

SELECT 
		p.TPN
		,p.EAN
		,p.TitleHU as [Description]
      ,sum(s.[Number]) as SumSales
	  ,round(pr.TescoRetailPrice,0) as SupplierRetailPrice
	  ,round(pr.TescoCostPrice,0) as SupplierCostPrice
	  ,st.SumStock

FROM [FR].[Sales] as s
INNER JOIN dbo.Product as p on p.ProductId = s.ProductId
INNER JOIN dbo.Price as pr on pr.ProductId = p.ProductId AND pr.StartDate <= s.EventDate AND (pr.EndDate > s.EventDate OR pr.EndDate IS NULL)
LEFT OUTER JOIN (
	SELECT st.ProductId, SUM(st.[Number]) as SumStock
	FRoM FR.StockClosing as st
	WHERE st.EventDate = @EndDate
	GROUP BY st.ProductId
) as st on st.ProductId = s.ProductId 

WHERE s.[EventDate] >= @StartDate AND s.[EventDate] <= @EndDate
		AND s.[Number] != 0

GROUP BY p.TPN
		,p.EAN
		,p.TitleHU
		  ,pr.TescoCostPrice
		  ,pr.TescoRetailPrice
		  ,st.SumStock

ORDER BY p.TPN asc


RETURN 0
