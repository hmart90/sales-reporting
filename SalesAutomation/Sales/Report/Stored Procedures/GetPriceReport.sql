﻿CREATE PROCEDURE [Report].[GetPriceReport]
	@ProductId INT
AS

SELECT p.TPN
		,p.TitleHU
		,ss.[Name]
      ,[StartDate]
      ,[EndDate]
      ,[SupplierRetailPrice]
      ,[SupplierCostPrice]
      ,[TescoRetailPrice]
      ,[TescoCostPrice]
FROM [dbo].[Price] as pr
INNER JOIN dbo.Product as p on p.ProductId = pr.ProductId
INNER JOIN dbo.SubSupplier as ss on ss.SubSupplierId = p.SubSupplierId

WHERE p.ProductId = @ProductId

ORDER BY p.TitleHU ASC, StartDate ASC

RETURN 0