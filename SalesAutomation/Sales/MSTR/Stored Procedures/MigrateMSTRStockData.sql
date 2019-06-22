CREATE PROCEDURE MSTR.[MigrateMSTRStockData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);

WITH SourceTable AS (
SELECT p.ProductId
		,[Stock units (Daily Shops)]
		,[Total Stock value Daily (cost price)]
		,st.StoreId
		,[Day] AS EventDate
FROM MSTR.[Staging_Stock] as sto
INNER JOIN dbo.Product as p ON p.TPN = sto.[Local TPN item TPN]
INNER JOIN dbo.Store as st ON st.Code = sto.[Local Store Store code]
WHERE [FileLoadId] = @FileLoadId
)

MERGE MSTR.Stock AS t
USING SourceTable AS s 
	ON (t.ProductId = s.ProductId
		AND t.EventDate = s.EventDate
		AND t.StoreId = s.StoreId) 
WHEN MATCHED
THEN UPDATE 
	SET t.[Number] = s.[Stock units (Daily Shops)],
		t.[CostPriceValue] = s.[Total Stock value Daily (cost price)]

WHEN NOT MATCHED BY TARGET 
THEN INSERT ([ProductId],[StoreId],[EventDate],[Number],[CostPriceValue]) VALUES (s.[ProductId],s.StoreId,s.EventDate,s.[Stock units (Daily Shops)],s.[Total Stock value Daily (cost price)]);

RETURN 0
