CREATE PROCEDURE [TMPL].[MigrateTemplatePriceData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE [Path] = @Path AND IsLoaded = 0);

DECLARE @Updates TABLE (
    ProductId INT NOT NULL,  
    [StartDate] DATE NOT NULL
);

with SourceTable AS (
SELECT	p.ProductId
      ,ISNULL([Új fogyasztói ár],pr.[SupplierRetailPrice]) AS [SupplierRetailPrice]
      ,ROUND(ISNULL([Új beszerzési ár],pr.[SupplierCostPrice]),2) AS [SupplierCostPrice]
      ,ISNULL([TESCO Új fogyasztói ár],pr.[TescoRetailPrice]) AS [TescoRetailPrice]
      ,ROUND(ISNULL([TESCO Új beszerzési ár],pr.[TescoCostPrice]),2) AS [TescoCostPrice]
      ,[Érvényességi dátum kezdete] AS StartDate
		,sto.Staging_PriceId
FROM TMPL.[Staging_Price] as sto
INNER JOIN dbo.Product as p ON p.TPN = sto.TPN
LEFT JOIN dbo.Price as pr on pr.ProductId = p.ProductId AND pr.EndDate IS NULL
WHERE [FileLoadId] = @FileLoadId
)

INSERT @Updates
    SELECT
        ProductId,
        StartDate
    FROM (
        MERGE INTO dbo.Price AS TARGET
        USING SourceTable AS SOURCE
            ON TARGET.ProductId = SOURCE.ProductId AND TARGET.EndDate IS NULL
        WHEN MATCHED
        THEN
            UPDATE SET
                EndDate = DATEADD(DAY, -1, CONVERT(DATE, SOURCE.StartDate))
        WHEN NOT MATCHED BY TARGET
        THEN
            INSERT (ProductId,[Staging_PriceId],StartDate,[SupplierRetailPrice],[SupplierCostPrice],[TescoRetailPrice],[TescoCostPrice]) VALUES(SOURCE.ProductId,SOURCE.[Staging_PriceId],SOURCE.StartDate,SOURCE.[SupplierRetailPrice],SOURCE.[SupplierCostPrice],SOURCE.[TescoRetailPrice],SOURCE.[TescoCostPrice])
        OUTPUT $action, INSERTED.ProductId, INSERTED.StartDate
    ) AllChanges (ActionType, ProductId, StartDate)
    WHERE AllChanges.ActionType = 'UPDATE';

with InsertSourceTable AS (
SELECT	p.ProductId
      ,ISNULL([Új fogyasztói ár],pr.[SupplierRetailPrice]) AS [SupplierRetailPrice]
      ,ROUND(ISNULL([Új beszerzési ár],pr.[SupplierCostPrice]),2) AS [SupplierCostPrice]
      ,ISNULL([TESCO Új fogyasztói ár],pr.[TescoRetailPrice]) AS [TescoRetailPrice]
      ,ROUND(ISNULL([TESCO Új beszerzési ár],pr.[TescoCostPrice]),2) AS [TescoCostPrice]
      ,[Érvényességi dátum kezdete] AS StartDate
		,sto.Staging_PriceId
FROM TMPL.[Staging_Price] as sto
INNER JOIN dbo.Product as p ON p.TPN = sto.TPN
LEFT JOIN dbo.Price as pr on pr.ProductId = p.ProductId AND pr.EndDate = DATEADD(DAY, -1, CONVERT(DATE,[Érvényességi dátum kezdete]))
WHERE [FileLoadId] = @FileLoadId
)

INSERT dbo.Price
(
		ProductId,
		StartDate,
		[SupplierRetailPrice],
		[SupplierCostPrice],
		[TescoRetailPrice],
		[TescoCostPrice],
		[Staging_PriceId])
SELECT
	SOURCE.ProductId,
	SOURCE.StartDate,
	SOURCE.[SupplierRetailPrice],
	SOURCE.[SupplierCostPrice],
	SOURCE.[TescoRetailPrice],
	SOURCE.[TescoCostPrice],
	SOURCE.Staging_PriceId
FROM InsertSourceTable SOURCE
WHERE EXISTS (
    SELECT *
    FROM @Updates Updates
    WHERE Updates.ProductId = SOURCE.ProductId
)

RETURN 0
