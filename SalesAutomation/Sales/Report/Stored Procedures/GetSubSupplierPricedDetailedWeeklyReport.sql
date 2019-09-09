CREATE PROCEDURE [Report].[GetSubSupplierPricedDetailedWeeklyReport]
	@StartDate DATE,
	@EndDate DATE,
	@SubSupplierId INT
AS

SELECT pm.[TPN]
      ,pm.[EAN]
      ,pm.Category
      ,ss.[Name] as SubSupplierName
      ,pm.TitleHU
	  ,st.Code
	  ,st.[Name] as StoreName
	  ,soldunits.EventDate
	  ,ISNULL(soldunits.Number,0) AS SoldUnitsTotal
	  ,pr.SupplierCostPrice
	  ,pr.SupplierRetailPrice
	 
FROM [dbo].[Product] as pm

INNER JOIN dbo.SubSupplier as ss on ss.SubSupplierId = pm.SubSupplierId
INNER JOIN dbo.Price as pr on pr.ProductId = pm.ProductId AND pr.StartDate <= @StartDate AND (pr.EndDate > @StartDate OR pr.EndDate IS NULL)

LEFT OUTER JOIN (
SELECT ProductId
		  ,StoreId
		  ,EventDate
		  ,Number
	FROM FR.Sales
	WHERE	EventDate >= @StartDate
			and EventDate <= @EndDate
) AS soldunits ON pm.ProductId = soldunits.ProductId 

inner join [dbo].[Store] as st on st.StoreId = soldunits.StoreId

where	pm.SubSupplierId = @SubSupplierId OR @SubSupplierId IS NULL
		  
ORDER BY
		pm.[TPN]
      ,pm.[EAN]
      ,pm.Category
      ,ss.[Name]
      ,pm.TitleHU

RETURN 0
