CREATE PROCEDURE [Report].[GetSubSupplierProductList]
	@SubSupplierId INT
AS

SELECT [ProductId]
      ,[TitleHU]
FROM [dbo].[Product] as p
WHERE SubSupplierId = @SubSupplierId

RETURN 0
