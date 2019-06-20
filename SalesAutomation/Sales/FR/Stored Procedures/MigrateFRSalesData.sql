CREATE PROCEDURE [FR].[MigrateFRSalesData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);

WITH SourceTable AS (
SELECT p.ProductId
      ,[Értékesített készlet (db)]
      ,[Beszerzési Egységár]
      ,[Értékesített készlet (érték)]
      ,[Árrés]
      ,[Nettó Árbevétel]
      ,[Bruttó Árbevétel]
      ,[Dátum] AS EventDate
      ,st.StoreId
FROM [FR].[Staging_Sales] as sto
INNER JOIN dbo.Product as p ON p.TPN = sto.TPN
INNER JOIN dbo.Store as st ON st.Code = sto.Site
WHERE [FileLoadId] = @FileLoadId
)

MERGE FR.Sales AS t
USING SourceTable AS s 
	ON (t.ProductId = s.ProductId
		AND t.EventDate = s.EventDate
		AND t.StoreId = s.StoreId) 
WHEN MATCHED
THEN UPDATE 
	SET	t.[Number] = s.[Értékesített készlet (db)],
		t.[CostPrice] = s.[Beszerzési Egységár],
		t.[ValueCostPrice] = s.[Értékesített készlet (érték)],
		t.[PriceMargin] = s.[Árrés],
		t.[NetSales] = s.[Nettó Árbevétel],
		t.[BrutSales] = s.[Bruttó Árbevétel]
		
WHEN NOT MATCHED BY TARGET 
THEN INSERT ([ProductId],[StoreId],[EventDate],[Number],[CostPrice],[ValueCostPrice],[PriceMargin],[NetSales],[BrutSales]) VALUES (s.[ProductId],s.StoreId,s.EventDate,s.[Értékesített készlet (db)],s.[Beszerzési Egységár],s.[Értékesített készlet (érték)],s.[Árrés],s.[Nettó Árbevétel],s.[Bruttó Árbevétel]);

RETURN 0
