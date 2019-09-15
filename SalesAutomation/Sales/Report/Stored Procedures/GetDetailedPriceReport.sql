CREATE PROCEDURE [Report].[GetDetailedPriceReport]

AS

	SELECT p.TPN
	     ,p.EAN
		,p.TitleHU
		,ss.[Name]
      ,[StartDate]
      ,[EndDate]
      ,[SupplierRetailPrice]
      ,[SupplierCostPrice]
      ,[TescoRetailPrice]
      ,[TescoCostPrice]
      ,first_sale.FirstSaleDate
FROM [dbo].[Price] as pr
INNER JOIN dbo.Product as p on p.ProductId = pr.ProductId
INNER JOIN dbo.SubSupplier as ss on ss.SubSupplierId = p.SubSupplierId
LEFT OUTER JOIN (
     SELECT ProductId, MIN (EventDate) as FirstSaleDate
     FROM MSTR.Sales
     GROUP BY ProductId
) as first_sale on first_sale.ProductId = p.ProductId

ORDER BY p.TitleHU ASC, StartDate ASC

RETURN 0
