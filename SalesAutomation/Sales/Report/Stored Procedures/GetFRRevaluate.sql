CREATE PROCEDURE [Report].[GetFRRevaluate]
	@StartDate DATE,
	@EndDate DATE
AS

SELECT [RevaluateId]
      ,s.[ProductId]
	  ,p.TitleHU
	  ,sp.[Name] as SupplierName
      ,s.[StoreId]
	  ,st.[Name] as StoreName
      ,s.[EventDate]
      ,[Number]
      ,[ValueCostPrice]
      ,[CorrectedBy]
      ,[ReasonCode]
      ,s.[InsertedUTC]
      ,s.[UpdatedUTC]
FROM [FR].[Revaluate] as s
INNER JOIN dbo.Store as st on st.StoreId = s.StoreId
INNER JOIN dbo.Product as p on p.ProductId = s.ProductId
INNER JOIN dbo.Supplier as sp on sp.SupplierId = p.SupplierId

WHERE @StartDate <= s.[EventDate] AND s.[EventDate] <= @EndDate

RETURN 0
