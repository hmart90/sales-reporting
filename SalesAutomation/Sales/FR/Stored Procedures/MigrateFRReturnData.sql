CREATE PROCEDURE [FR].[MigrateFRReturnData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);

WITH SourceTable AS (
SELECT p.ProductId
      ,[KészletMennyiség]
      ,[BeszEgységár]
      ,[ÉrtékOnktgAron]
      ,st.StoreId
	  ,date AS EventDate
	  ,sto.Staging_StockReturnId AS StagingId
FROM [FR].[Staging_StockReturn] as sto
INNER JOIN dbo.Product as p ON p.TPN = sto.[tpn]
INNER JOIN dbo.Store as st ON st.Code = sto.[site]
WHERE [FileLoadId] = @FileLoadId
)

MERGE FR.StockReturn AS t
USING SourceTable AS s 
	ON (t.ProductId = s.ProductId
		AND t.EventDate = s.EventDate
		AND t.StoreId = s.StoreId) 
WHEN MATCHED
THEN UPDATE 
	SET t.[Number] = s.[KészletMennyiség],
		t.[CostUnitPrice] = s.[BeszEgységár],
		t.[ValueCostPrice] = s.[ÉrtékOnktgAron],
		t.Staging_StockReturnId = s.StagingId

WHEN NOT MATCHED BY TARGET 
THEN INSERT ([ProductId],[StoreId],[EventDate],[Number],[CostUnitPrice],[ValueCostPrice],Staging_StockReturnId) VALUES (s.[ProductId],s.StoreId,s.EventDate,s.[KészletMennyiség],s.[BeszEgységár],s.[ÉrtékOnktgAron],s.StagingId);

RETURN 0
