CREATE PROCEDURE [Report].[GetFRStockClosing]
	@EventDate DATE
AS

SELECT [StockClosingId]
      ,s.[ProductId]
	  ,p.TitleHU
	  ,sp.[Name] as SupplierName
      ,s.[StoreId]
	  ,st.[Name] as StoreName
      ,[EventDate]
      ,[Number]
      ,[CostUnitPrice]
      ,[ValueCostPrice]
      ,[ValueRetailPrice]
      ,s.[InsertedUTC]
      ,s.[UpdatedUTC]
FROM [FR].[StockClosing] as s
INNER JOIN dbo.Store as st on st.StoreId = s.StoreId
INNER JOIN dbo.Product as p on p.ProductId = s.ProductId
INNER JOIN dbo.Supplier as sp on sp.SupplierId = p.SupplierId

WHERE @EventDate = s.[EventDate]


RETURN 0
