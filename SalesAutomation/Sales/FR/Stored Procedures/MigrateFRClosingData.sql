CREATE PROCEDURE [FR].[MigrateFRClosingData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);
DECLARE @EventDate DATE = (SELECT EndDate FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);

WITH SourceTable AS (
SELECT p.ProductId
      ,[Státusz]
      ,[KészletMennyiség]
      ,[BeszEgységár]
      ,[ÉrtékOnktgAron]
      ,[ÉrtékFogyAron]
      ,st.StoreId
	  ,@EventDate AS EventDate
	  ,sto.Staging_StockClosingId AS StagingId
FROM [FR].[Staging_StockClosing] as sto
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
	SET t.[Number] = s.[KészletMennyiség],
		t.[CostUnitPrice] = s.[BeszEgységár],
		t.[ValueCostPrice] = s.[ÉrtékOnktgAron],
		t.[ValueRetailPrice] = s.[ÉrtékFogyAron],
		t.Staging_StockClosingId = s.StagingId

WHEN NOT MATCHED BY TARGET 
THEN INSERT ([ProductId],[StoreId],[EventDate],[Number],[CostUnitPrice],[ValueCostPrice],[ValueRetailPrice],Staging_StockClosingId) VALUES (s.[ProductId],s.StoreId,s.EventDate,s.[KészletMennyiség],s.[BeszEgységár],s.[ÉrtékOnktgAron],s.[ÉrtékFogyAron],s.StagingId);

RETURN 0
