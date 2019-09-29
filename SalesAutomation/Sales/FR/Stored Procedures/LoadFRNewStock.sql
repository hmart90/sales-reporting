CREATE PROCEDURE [FR].[LoadFRNewStock]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0)
DECLARE @SQL AS NVARCHAR(MAX)

SET @SQL = '
INSERT INTO [FR].[Staging_NewStock]
           ([FileLoadId]
           ,[Site]
           ,[Site name]
           ,[Supplier ID]
           ,[TPN]
           ,[TPN description]
           ,[Last closing stock QTY]
           ,[Receivings QTY]
           ,[Returns QTY]
           ,[Returns at COST]
           ,[Stock adjustments QTY]
           ,[Stock adjustments at value]
           ,[Stock-Take adjustments QTY]
           ,[Stock-Take adjustments at value]
           ,[Transfers OUT QTY]
           ,[Transfers IN QTY]
           ,[Sales QTY]
           ,[Stock in transit QTY]
           ,[Unprocessed movements QTY]
           ,[Closing stock QTY]
           ,[COGS]
           ,[Gross margin]
           ,[Sales at retail incl VAT]
           ,[VAT]
           ,[Sales at retail excl VAT]
           ,[Consignment fee %]
           ,[Fee value netto]
           ,[Sales at retail excl vat excl fee]
           ,[Invoicing model])
SELECT 
           ' + CAST(@FileLoadId AS NVARCHAR(100)) + '
           ,[Site]
           ,[Site name]
           ,[Supplier ID]
           ,[TPN]
           ,[TPN description]
           ,[Last closing stock QTY]
           ,[Receivings QTY]
           ,[Returns QTY]
           ,[Returns at COST]
           ,[Stock adjustments QTY]
           ,[Stock adjustments at value]
           ,[Stock-Take adjustments QTY]
           ,[Stock-Take adjustments at value]
           ,[Transfers OUT QTY]
           ,[Transfers IN QTY]
           ,[Sales QTY]
           ,[Stock in transit QTY]
           ,[Unprocessed movements QTY]
           ,[Closing stock QTY]
           ,[COGS]
           ,[Gross margin]
           ,[Sales at retail incl VAT]
           ,[VAT]
           ,[Sales at retail excl VAT]
           ,[Consignment fee %]
           ,[Fee value netto]
           ,[Sales at retail excl vat excl fee]
           ,[Invoicing model]

FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.12.0''
	,''Excel 12.0;Database=' + @Path + ';HDR=YES''
	,''SELECT * FROM [Stock turnover$A3:AZ]'')'

EXEC (@SQL)

RETURN 0
