CREATE PROCEDURE [NLF].[MigrateRangeData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);

WITH SourceTable AS (
SELECT	p.ProductId
		,[Store number] as [ConnectionCount]
		,[range hónap] AS EventDate
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
	SET t.[ConnectionCount] = s.[ConnectionCount]

WHEN NOT MATCHED BY TARGET 
THEN INSERT ([ProductId],[EventDate],[ConnectionCount]) VALUES (s.[ProductId],s.EventDate,s.[ConnectionCount]);

RETURN 0