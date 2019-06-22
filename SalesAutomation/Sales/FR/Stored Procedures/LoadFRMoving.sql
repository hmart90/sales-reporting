CREATE PROCEDURE [FR].[LoadFRMoving]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0)
DECLARE @SQL AS NVARCHAR(MAX)

SET @SQL = '
INSERT INTO [FR].[Staging_StockMoving]
           ([FileLoadId],
			[tpn],
			[Product],
			[date_e],
			[corr],
			[KészletMennyiség],
			[BeszEgységár],
			[ÉrtékOnktgAron],
			[date],
			[site],
			[Comment])
SELECT 
           ' + CAST(@FileLoadId AS NVARCHAR(100)) + '
		   ,[tpn]	
		   ,[Product]	
		   ,[date_e]	
		   ,[corr]	
		   ,[KészletMennyiség]	
		   ,[BeszEgységár]	
		   ,[ÉrtékOnktgAron]	
		   ,[date]
		   ,[site]
		   ,[Comment]

FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.12.0''
	,''Excel 12.0;Database=' + @Path + ';HDR=YES''
	,''SELECT * FROM [Készletmozgások$A1:Z]'')
WHERE [tpn] IS NOT NULL
'

EXEC (@SQL)

RETURN 0
