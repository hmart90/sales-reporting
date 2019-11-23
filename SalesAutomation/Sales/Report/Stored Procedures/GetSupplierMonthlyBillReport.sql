CREATE PROCEDURE [Report].[GetSupplierMonthlyBillReport]
	@StartDate DATE,
	@EndDate DATE,
	@SubSupplierId INT
AS

SELECT 
		p.TPN
		,p.EAN
		,p.TitleHU as [Description]
      ,sum(s.[Number]) as SumSales
	  ,round(pr.SupplierRetailPrice,0) as SupplierRetailPrice
	  ,round(pr.SupplierCostPrice,0) as SupplierCostPrice
	  ,st.SumStock

FROM [FR].[MonthlySales] as s
INNER JOIN dbo.Product as p on p.ProductId = s.ProductId
INNER JOIN dbo.Price as pr on pr.ProductId = p.ProductId AND pr.StartDate <= s.EventDate AND (pr.EndDate >= s.EventDate OR pr.EndDate IS NULL)
LEFT OUTER JOIN (
	SELECT st.ProductId, SUM(st.[Number]) as SumStock
	FRoM FR.MonthlyStockClosing as st
	WHERE st.EventDate = @EndDate
	GROUP BY st.ProductId
) as st on st.ProductId = s.ProductId 

WHERE s.[EventDate] >= @StartDate AND s.[EventDate] <= @EndDate
		AND s.[Number] != 0
		AND p.SubSupplierId = @SubSupplierId

GROUP BY p.TPN
		,p.EAN
		,p.TitleHU
		  ,pr.SupplierRetailPrice
		  ,pr.SupplierCostPrice
		  ,st.SumStock

ORDER BY p.TPN asc

RETURN 0
