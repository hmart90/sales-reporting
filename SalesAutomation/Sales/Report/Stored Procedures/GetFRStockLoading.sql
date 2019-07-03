CREATE PROCEDURE [Report].[GetFRStockLoading]
	@StartDate DATE,
	@EndDate DATE
AS
SELECT [StockLoadingId]
      ,s.[ProductId]
	  ,p.TitleHU
	  ,sp.[Name] as SupplierName
      ,s.[StoreId]
	  ,st.[Name] as StoreName
      ,[EventDate]
      ,[Number]
      ,[CostUnitPrice]
      ,[ValueCostPrice]
      ,s.[InsertedUTC]
      ,s.[UpdatedUTC]
FROM [FR].[StockLoading] as s
INNER JOIN dbo.Store as st on st.StoreId = s.StoreId
INNER JOIN dbo.Product as p on p.ProductId = s.ProductId
INNER JOIN dbo.Supplier as sp on sp.SupplierId = p.SupplierId

WHERE @StartDate <= s.[EventDate] AND s.[EventDate] <= @EndDate

RETURN 0
