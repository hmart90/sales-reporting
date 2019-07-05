CREATE PROCEDURE [FR].[MigrateFRRevaluateData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);

WITH SourceTable AS (
SELECT p.ProductId
      ,[KészletMennyiség]
      ,[ÉrtékOnktgAron]
      ,[Corrected by]
	  ,[Reason code]
      ,st.StoreId
	  ,date AS EventDate
	  ,sto.Staging_RevaluateId AS StagingId
FROM [FR].[Staging_Revaluate] as sto
INNER JOIN dbo.Product as p ON p.TPN = sto.TPN
INNER JOIN dbo.Store as st ON st.Code = sto.Site
WHERE [FileLoadId] = @FileLoadId
)

MERGE FR.Revaluate AS t
USING SourceTable AS s 
	ON (t.ProductId = s.ProductId
		AND t.EventDate = s.EventDate
		AND t.StoreId = s.StoreId) 
WHEN MATCHED
THEN UPDATE 
	SET t.[Number] = s.[KészletMennyiség],
		t.[ValueCostPrice] = s.[ÉrtékOnktgAron],
		t.[CorrectedBy] = s.[Corrected by],
		t.[ReasonCode] = s.[Reason code],
		t.Staging_RevaluateId = s.StagingId

WHEN NOT MATCHED BY TARGET 
THEN INSERT ([ProductId],[StoreId],[EventDate],[Number],[ValueCostPrice],[CorrectedBy],[ReasonCode],Staging_RevaluateId) VALUES (s.[ProductId],s.StoreId,s.EventDate,s.[KészletMennyiség],s.[ÉrtékOnktgAron],s.[Corrected by],s.[Reason code],s.StagingId);

RETURN 0
