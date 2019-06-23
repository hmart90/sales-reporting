CREATE PROCEDURE [MSTR].[AutoCreateNewItemsFromMSTRSales]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);
DECLARE @SheetName as nvarchar(500);
DECLARE @Category AS NVARCHAR(100);
SET @SheetName = (SELECT TOP 1 SheetName FROM dbo.TempExcelSheet WHERE SheetName LIKE 'DVD%' OR SheetName LIKE 'Gaming%');
SET @Category = (CASE WHEN @SheetName like 'Gaming%' THEN 'Gaming' ELSE 'Film' END);

INSERT INTO [dbo].[Supplier]
           ([Name]
		   ,[TescoCode]
		   ,TescoName
		   ,IsAutoCreated)
SELECT
	sts.[Local Active supplier Long description]
	,sts.[Local Active supplier Code]
	,sts.[Local Active supplier Long description]
	,1

FROM MSTR.Staging_Sales as sts
LEFT JOIN dbo.Supplier as s ON s.TescoCode = sts.[Local Active supplier Code] OR (s.TescoName = sts.[Local Active supplier Long description] AND sts.[Local Active supplier Code] IS NULL)
WHERE s.SupplierId IS NULL AND sts.FileLoadId = @FileLoadId
GROUP BY 	sts.[Local Active supplier Long description]
			,sts.[Local Active supplier Code]
			,sts.[Local Active supplier Long description]

INSERT INTO [dbo].Product
	([SupplierId],
	[TPN],
	[EAN],
	[TitleHU],
	[Category],
	[IsAutoCreated])
SELECT
	s.SupplierId
	,sts.[Local TPN item TPN]
	,sts.[Local TPN item Primary EAN]
	,sts.[Local TPN item Long description]
	,@Category
	,1
FROM MSTR.Staging_Sales as sts
INNER JOIN dbo.Supplier as s ON s.TescoCode = sts.[Local Active supplier Code] OR (s.TescoName = sts.[Local Active supplier Long description] AND sts.[Local Active supplier Code] IS NULL)
LEFT JOIN dbo.Product as p ON p.TPN = sts.[Local TPN item TPN]
WHERE p.ProductId IS NULL AND sts.FileLoadId = @FileLoadId
GROUP BY 
	s.SupplierId
	,sts.[Local TPN item TPN]
	,sts.[Local TPN item Primary EAN]
	,sts.[Local TPN item Long description]

RETURN 0
