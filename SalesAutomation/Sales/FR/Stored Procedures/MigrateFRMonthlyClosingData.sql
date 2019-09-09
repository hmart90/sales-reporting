CREATE PROCEDURE [FR].[MigrateFRMonthlyClosingData]
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
	  ,sto.Staging_MonthlyStockClosingId AS StagingId
FROM [FR].[Staging_MonthlyStockClosing] as sto
INNER JOIN dbo.Product as p ON p.TPN = sto.TPN
INNER JOIN dbo.Store as st ON st.Code = sto.Site
WHERE [FileLoadId] = @FileLoadId
)

MERGE FR.MonthlyStockClosing AS t
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
		t.Staging_MonthlyStockClosingId = s.StagingId

WHEN NOT MATCHED BY TARGET 
THEN INSERT ([ProductId],[StoreId],[EventDate],[Number],[CostUnitPrice],[ValueCostPrice],[ValueRetailPrice],Staging_MonthlyStockClosingId) VALUES (s.[ProductId],s.StoreId,s.EventDate,s.[KészletMennyiség],s.[BeszEgységár],s.[ÉrtékOnktgAron],s.[ÉrtékFogyAron],s.StagingId);

RETURN 0
