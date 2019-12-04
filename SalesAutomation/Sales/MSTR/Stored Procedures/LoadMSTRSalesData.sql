CREATE PROCEDURE MSTR.[LoadMSTRSalesData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);
DECLARE @SQL AS NVARCHAR(MAX);
DECLARE @SheetName as nvarchar(500);
SET @SheetName = (SELECT TOP 1 SheetName FROM dbo.TempExcelSheet WHERE SheetName LIKE 'DVD%' OR SheetName LIKE 'Gaming%' OR SheetName = 'Delta-sales');

SET @SQL = '
INSERT INTO [MSTR].[Staging_Sales]
           ([FileLoadId],
			[Local TPN item TPN],
			[Local TPN item Long description],
			[Local TPN item Primary EAN],
			[Local Active supplier Code],
			[Local Active supplier Long description],
			[Local Store Store code],
			[Local Store Store name],
			[Day],
			[Fiscal week],
			[Sold units],
			[Sales excl VAT],
			[Scan margin])
SELECT 
           ' + CAST(@FileLoadId AS NVARCHAR(100)) + ',
			[Local TPN item TPN],
			[Local TPN item Long description],
			[Local TPN item Primary EAN],
			[Local Active supplier Code],
			[Local Active supplier Long description],
			[Local Store Store code],
			[Local Store Store name],
			[Day],
			[Fiscal week],
			[Sold units],
			[Sales excl VAT],
			[Scan margin]

FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.12.0''
	,''Excel 12.0;Database=' + @Path + ';HDR=YES''
	,''SELECT * FROM [' + @SheetName + '$A4:Z]'')'

EXEC (@SQL)

RETURN 0
