CREATE PROCEDURE [Report].[GetProductList]
	@IsAutoCreated BIT
AS
SELECT [ProductId]
      ,p.[SupplierId]
	  ,sp.[Name]
      ,[TPN]
      ,[EAN]
      ,[TitleHU]
      ,[TitleEN]
      ,[Category]
      ,[StoreConnection]
      ,[Space]
      ,p.[IsAutoCreated]
      ,p.[InsertedUTC]
      ,p.[UpdatedUTC]
FROM [dbo].[Product] AS p
INNER JOIN dbo.Supplier as sp on sp.SupplierId = p.SupplierId

WHERE p.[IsAutoCreated] = @IsAutoCreated OR @IsAutoCreated IS NULL

RETURN 0
