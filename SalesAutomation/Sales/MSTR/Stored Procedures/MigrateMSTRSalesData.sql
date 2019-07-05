CREATE PROCEDURE MSTR.[MigrateMSTRSalesData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);

WITH SourceTable AS (
SELECT p.ProductId
		,[Sold units]
		,[Sales excl VAT]
		,[Scan margin]
		,st.StoreId
		,[Day] AS EventDate
		,sto.Staging_SalesId
FROM MSTR.[Staging_Sales] as sto
INNER JOIN dbo.Product as p ON p.TPN = sto.[Local TPN item TPN]
INNER JOIN dbo.Store as st ON st.Code = sto.[Local Store Store code]
WHERE [FileLoadId] = @FileLoadId
)

MERGE MSTR.Sales AS t
USING SourceTable AS s 
	ON (t.ProductId = s.ProductId
		AND t.EventDate = s.EventDate
		AND t.StoreId = s.StoreId) 
WHEN MATCHED
THEN UPDATE 
	SET t.[Number] = s.[Sold units],
		t.SalesExclVAT = s.[Sales excl VAT],
		t.[Margin] = s.[Scan margin],
		t.Staging_SalesId = s.Staging_SalesId

WHEN NOT MATCHED BY TARGET 
THEN INSERT ([ProductId],[StoreId],[EventDate],[Number],SalesExclVAT,[Margin],Staging_SalesId) VALUES (s.[ProductId],s.StoreId,s.EventDate,s.[Sold units],s.[Sales excl VAT],s.[Scan margin],s.Staging_SalesId);

RETURN 0
