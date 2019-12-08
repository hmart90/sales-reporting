CREATE PROCEDURE [FR].[MigrateFRNewStockData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);
DECLARE @EventDate DATE = (SELECT EndDate FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);

WITH SourceTable AS (
SELECT p.ProductId
      ,[Closing stock QTY]
      ,0 as [BeszEgységár]
      ,0 as [ÉrtékOnktgAron]
      ,0 as [ÉrtékFogyAron]
      ,st.StoreId
	  ,@EventDate AS EventDate
	  ,sto.Staging_NewStockId AS StagingId
FROM [FR].[Staging_NewStock] as sto
INNER JOIN dbo.Product as p ON p.TPN = sto.TPN
INNER JOIN dbo.Store as st ON st.Code = sto.Site
WHERE [FileLoadId] = @FileLoadId
)

MERGE FR.StockClosing AS t
USING SourceTable AS s 
	ON (t.ProductId = s.ProductId
		AND t.EventDate = s.EventDate
		AND t.StoreId = s.StoreId) 
WHEN MATCHED
THEN UPDATE 
	SET t.[Number] = s.[Closing stock QTY],
		t.[CostUnitPrice] = s.[BeszEgységár],
		t.[ValueCostPrice] = s.[ÉrtékOnktgAron],
		t.[ValueRetailPrice] = s.[ÉrtékFogyAron]

WHEN NOT MATCHED BY TARGET 
THEN INSERT ([ProductId],[StoreId],[EventDate],[Number],[CostUnitPrice],[ValueCostPrice],[ValueRetailPrice]) VALUES (s.[ProductId],s.StoreId,s.EventDate,s.[Closing stock QTY],s.[BeszEgységár],s.[ÉrtékOnktgAron],s.[ÉrtékFogyAron]);

RETURN 0
