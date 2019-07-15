CREATE PROCEDURE [Report].[GetSubSupplierWeeklyReport]
	@StartDate DATE,
	@EndDate DATE,
	@SubSupplierId INT
AS

SELECT pm.[TPN]
      ,pm.[EAN]
      ,pm.Category
      ,ss.[Name]
      ,pm.TitleHU
	  ,ISNULL(soldunitstotal.SoldUnitsTotal,0) AS SoldUnitsTotal
	  ,prm.SupplierRetailPrice
	  ,prm.SupplierCostPrice
	  ,prm.SupplierCostPrice*ISNULL(soldunitstotal.SoldUnitsTotal,0) AS [Értékesítés értéke]
	  ,ISNULL(laststockunitstotal.LastStockUnitsTotal,0) AS [StockUnitsTotal]

FROM [dbo].[Product] as pm
INNER JOIN dbo.SubSupplier as ss on ss.SubSupplierId = pm.SubSupplierId

LEFT OUTER JOIN (
	SELECT ProductId
		  ,sum(Number) AS SoldUnitsTotal
	FROM MSTR.Sales
	WHERE	EventDate >= @StartDate
			and EventDate <= @EndDate
	GROUP BY ProductId
) AS soldunitstotal ON pm.ProductId = soldunitstotal.ProductId 

INNER JOIN dbo.Price AS prm ON prm.ProductId = pm.ProductId AND prm.EndDate IS NULL

LEFT OUTER JOIN (
	SELECT ProductId
		  ,sum(Number) AS LastStockUnitsTotal
	FROM MSTR.Stock
	WHERE	EventDate = @EndDate
	GROUP BY ProductId
) AS laststockunitstotal ON pm.ProductId = laststockunitstotal.ProductId 

where	pm.SubSupplierId = @SubSupplierId OR @SubSupplierId IS NULL
		  
ORDER BY
		pm.[TPN]
      ,pm.[EAN]
      ,pm.Category
      ,ss.[Name]
      ,pm.TitleHU

RETURN 0
