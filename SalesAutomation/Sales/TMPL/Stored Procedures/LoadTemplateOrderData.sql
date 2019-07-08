CREATE PROCEDURE TMPL.[LoadTemplateOrderData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);
DECLARE @SQL AS NVARCHAR(MAX);

SET @SQL = '
INSERT INTO [TMPL].[Staging_OrderProductCount]
           ([FileLoadId],
			[TPN],
			[Description],
			[Normal price],
			[Cost price (Tesco)],
			[Cost price in GBP],
			[Quantity],
			[Min],
			[Max])
SELECT 
           ' + CAST(@FileLoadId AS NVARCHAR(100)) + ',
			[TPN],
			[Description],
			[Normal price],
			[Cost price (Tesco)],
			[Cost price in GBP],
			[Quantity],
			[Min],
			[Max]

FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.12.0''
	,''Excel 12.0;Database=' + @Path + ';HDR=YES''
	,''SELECT * FROM [rendelés$A2:Z]'')
WHERE 
			[TPN] IS NOT NULL AND
			[Quantity] IS NOT NULL AND [Quantity] > 0
	'

EXEC (@SQL)

RETURN 0