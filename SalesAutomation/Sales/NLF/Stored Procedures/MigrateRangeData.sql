CREATE PROCEDURE [NLF].[MigrateRangeData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);

WITH SourceTable AS (
SELECT	p.ProductId
		,[Store number] as [ConnectionCount]
		,[range hónap] AS EventDate
		,sto.Staging_RangeId
		,sto.[fogyár] AS Price
FROM NLF.[Staging_Range] as sto
INNER JOIN dbo.Product as p ON p.TPN = sto.[TPN]
WHERE [FileLoadId] = @FileLoadId
)

MERGE NLF.[Range] AS t
USING SourceTable AS s 
	ON (t.ProductId = s.ProductId
		AND t.EventDate = s.EventDate) 
WHEN MATCHED
THEN UPDATE 
	SET t.[ConnectionCount] = s.[ConnectionCount],
		t.Staging_RangeId = s.Staging_RangeId,
		t.Price = s.Price

WHEN NOT MATCHED BY TARGET 
THEN INSERT ([ProductId],[EventDate],[ConnectionCount],Staging_RangeId,Price) VALUES (s.[ProductId],s.EventDate,s.[ConnectionCount],s.Staging_RangeId,s.Price);

RETURN 0