CREATE PROCEDURE [FR].[MigrateFRNewSalesData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);

WITH SourceTable AS (
SELECT p.ProductId
      ,[Sales QTY]
      ,0 as [Beszerzési Egységár]
      ,0 as [Értékesített készlet (érték)]
      ,[Gross margin]
      ,[Sales at retail price excl VAT]
      ,0 as [Bruttó Árbevétel]
      ,[Day] AS EventDate
      ,st.StoreId
	  ,sto.Staging_NewSalesId AS StagingId
FROM [FR].[Staging_NewSales] as sto
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
	SET	t.[Number] = s.[Sales QTY],
		t.[CostPrice] = s.[Beszerzési Egységár],
		t.[ValueCostPrice] = s.[Értékesített készlet (érték)],
		t.[PriceMargin] = s.[Gross margin],
		t.[NetSales] = s.[Sales at retail price excl VAT],
		t.[BrutSales] = s.[Bruttó Árbevétel]
		
WHEN NOT MATCHED BY TARGET 
THEN INSERT ([ProductId],[StoreId],[EventDate],[Number],[CostPrice],[ValueCostPrice],[PriceMargin],[NetSales],[BrutSales]) VALUES (s.[ProductId],s.StoreId,s.EventDate,s.[Sales QTY],s.[Beszerzési Egységár],s.[Értékesített készlet (érték)],s.[Gross margin],s.[Sales at retail price excl VAT],s.[Bruttó Árbevétel]);

RETURN 0
