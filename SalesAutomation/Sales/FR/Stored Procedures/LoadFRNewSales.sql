CREATE PROCEDURE [FR].[LoadFRNewSales]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0)
DECLARE @SQL AS NVARCHAR(MAX)

SET @SQL = '
INSERT INTO [FR].[Staging_NewSales]
           ([FileLoadId]
           ,[Site]
           ,[TPN]
           ,[Supplier ID]
           ,[Div]
           ,[Dep]
           ,[Sec]
           ,[Day]
           ,[Sales QTY]
           ,[Sales at retail price excl VAT]
           ,[Gross margin]
           ,[Sales at cost price]
           ,[VAT rate])

SELECT 
           ' + CAST(@FileLoadId AS NVARCHAR(100)) + '
           ,[Site]
           ,[TPN]
           ,[Supplier ID]
           ,[Div]
           ,[Dep]
           ,[Sec]
           ,[Day]
           ,[Sales QTY]
           ,[Sales at retail price excl VAT]
           ,[Gross margin]
           ,[Sales at cost price]
           ,[VAT rate]

FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.12.0''
	,''Excel 12.0;Database=' + @Path + ';HDR=YES''
	,''SELECT * FROM [Daily sales$A3:Z]'')
'

EXEC (@SQL)

RETURN 0
