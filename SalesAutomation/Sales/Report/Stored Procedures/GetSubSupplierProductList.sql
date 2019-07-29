CREATE PROCEDURE [Report].[GetSubSupplierProductList]
	@SubSupplierId INT
AS

SELECT [ProductId]
      ,[TitleHU]
FROM [dbo].[Product] as p
WHERE SubSupplierId = @SubSupplierId

UNION ALL

SELECT NULL, NULL

RETURN 0
