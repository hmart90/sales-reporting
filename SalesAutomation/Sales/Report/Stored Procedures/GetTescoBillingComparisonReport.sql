CREATE PROCEDURE [Report].[GetTescoBillingComparisonReport]
	@StartDate DATE,
	@EndDate DATE
AS


SELECT 
		p.TPN
		,p.EAN
		,p.TitleHU as [Description]
	  ,round(pr.TescoRetailPrice,2) as SupplierRetailPrice
	  ,round(pr.TescoCostPrice,2) as SupplierCostPrice
	  ,frst.SumStock as FinanceSumStock
	  ,mstrst.SumStock as MSTRSumStock
	  ,frs.SumSales as FinanceSumSales
	  ,mstrs.SumSales as MSTRSumSales

FROM  dbo.Product as p
INNER JOIN dbo.Price as pr on pr.ProductId = p.ProductId AND pr.StartDate <= @EndDate AND (pr.EndDate >= @StartDate OR pr.EndDate IS NULL)
LEFT OUTER JOIN (
	SELECT st.ProductId, SUM(st.[Number]) as SumStock
	FROM FR.StockClosing as st
	WHERE st.EventDate = @EndDate
	GROUP BY st.ProductId
) as frst on frst.ProductId = p.ProductId 

LEFT OUTER JOIN (
	SELECT st.ProductId, SUM(st.[Number]) as SumStock
	FROM MSTR.Stock as st
	WHERE st.EventDate = @EndDate
	GROUP BY st.ProductId
) as mstrst on mstrst.ProductId = p.ProductId 

LEFT OUTER JOIN (
	SELECT s.ProductId
		,SUM(s.[Number]) as SumSales
	  ,round(pr.TescoRetailPrice,2) as SupplierRetailPrice
	  ,round(pr.TescoCostPrice,2) as SupplierCostPrice
	FROM [FR].[Sales] as s
	INNER JOIN dbo.Price as pr on pr.ProductId = s.ProductId AND pr.StartDate <= s.EventDate AND (pr.EndDate >= s.EventDate OR pr.EndDate IS NULL)
	WHERE s.[EventDate] >= @StartDate AND s.[EventDate] <= @EndDate
		AND s.[Number] != 0
	GROUP BY s.ProductId, round(pr.TescoRetailPrice,2), round(pr.TescoCostPrice,2)
) as frs on frs.ProductId = p.ProductId AND frs.SupplierRetailPrice = round(pr.TescoRetailPrice,2) AND frs.SupplierCostPrice = round(pr.TescoCostPrice,2)

LEFT OUTER JOIN (
	SELECT s.ProductId
		,SUM(s.[Number]) as SumSales
	  ,round(pr.TescoRetailPrice,2) as SupplierRetailPrice
	  ,round(pr.TescoCostPrice,2) as SupplierCostPrice
	FROM MSTR.[Sales] as s
	INNER JOIN dbo.Price as pr on pr.ProductId = s.ProductId AND pr.StartDate <= s.EventDate AND (pr.EndDate >= s.EventDate OR pr.EndDate IS NULL)
	WHERE s.[EventDate] >= @StartDate AND s.[EventDate] <= @EndDate
		AND s.[Number] != 0
	GROUP BY s.ProductId, round(pr.TescoRetailPrice,2), round(pr.TescoCostPrice,2)
) as mstrs on mstrs.ProductId = p.ProductId AND mstrs.SupplierRetailPrice = round(pr.TescoRetailPrice,2) AND mstrs.SupplierCostPrice = round(pr.TescoCostPrice,2)

WHERE p.SubSupplierId IS NOT NULL

ORDER BY p.TPN asc
GO

