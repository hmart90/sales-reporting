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

FROM [FR].[MonthlySales] as s
INNER JOIN dbo.Product as p on p.ProductId = s.ProductId
INNER JOIN dbo.Price as pr on pr.ProductId = p.ProductId AND pr.StartDate <= s.EventDate AND (pr.EndDate > s.EventDate OR pr.EndDate IS NULL)

WHERE [EventDate] >= @StartDate AND [EventDate] <= @EndDate
		AND s.[Number] != 0
		AND p.SubSupplierId = @SubSupplierId

GROUP BY p.TPN
		,p.EAN
		,p.TitleHU
		  ,pr.SupplierRetailPrice
		  ,pr.SupplierCostPrice

ORDER BY p.TPN asc

RETURN 0
