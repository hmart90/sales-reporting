CREATE PROCEDURE [FR].[AutoCreateNewItemsFromFR]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);
DECLARE @SupplierId INT = (SELECT SupplierId FROM dbo.Supplier WHERE [Name] = 'DCMS');

INSERT INTO [dbo].Product
	([SupplierId],
	[TPN],
	[TitleHU],
	[Category],
	[IsAutoCreated])
SELECT
	@SupplierId
	,sts.TPN
	,sts.Description
	,(CASE WHEN sts.Dep = 170 THEN 'Film' ELSE 'Gaming' END)
	,1
FROM FR.Staging_Sales as sts
LEFT JOIN dbo.Product as p ON p.TPN = sts.TPN
WHERE p.[TPN] IS NULL AND sts.FileLoadId = @FileLoadId
GROUP BY 
	sts.TPN
	,sts.Description
	,(CASE WHEN sts.Dep = 170 THEN 'Film' ELSE 'Gaming' END)

INSERT INTO [dbo].Product
	([SupplierId],
	[TPN],
	[TitleHU],
	[Category],
	[IsAutoCreated])
SELECT
	@SupplierId
	,sts.TPN
	,sts.Description
	,(CASE WHEN sts.Dep = 170 THEN 'Film' ELSE 'Gaming' END)
	,1
FROM FR.Staging_StockOpening as sts
LEFT JOIN dbo.Product as p ON p.TPN = sts.TPN
WHERE p.[TPN] IS NULL AND sts.FileLoadId = @FileLoadId
GROUP BY 
	sts.TPN
	,sts.Description
	,(CASE WHEN sts.Dep = 170 THEN 'Film' ELSE 'Gaming' END)


INSERT INTO [dbo].Product
	([SupplierId],
	[TPN],
	[TitleHU],
	[Category],
	[IsAutoCreated])
SELECT
	@SupplierId
	,sts.TPN
	,sts.Description
	,(CASE WHEN sts.Dep = 170 THEN 'Film' ELSE 'Gaming' END)
	,1
FROM FR.Staging_StockClosing as sts
LEFT JOIN dbo.Product as p ON p.TPN = sts.TPN
WHERE p.[TPN] IS NULL AND sts.FileLoadId = @FileLoadId
GROUP BY 
	sts.TPN
	,sts.Description
	,(CASE WHEN sts.Dep = 170 THEN 'Film' ELSE 'Gaming' END)

RETURN 0;