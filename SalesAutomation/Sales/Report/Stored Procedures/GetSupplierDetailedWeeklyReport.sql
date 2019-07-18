CREATE PROCEDURE [Report].[GetSubSupplierDetailedWeeklyReport]
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
	 

FROM [dbo].[Product] as pm

INNER JOIN dbo.SubSupplier as ss on ss.SubSupplierId = pm.SubSupplierId

LEFT OUTER JOIN (
SELECT ProductId
		  ,StoreId
		  ,EventDate
		  ,Number
	FROM MSTR.Sales
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
