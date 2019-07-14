CREATE PROCEDURE [TMPL].[LoadTemplatePriceData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);
DECLARE @SQL AS NVARCHAR(MAX);

SET @SQL = '
INSERT INTO [TMPL].[Staging_Price]
           ([FileLoadId],
			[TPN],	
			[Megnevezés],	
			[Forgalmazó],	
			[Új fogyasztói ár],	
			[Új beszerzési ár],	
			[TESCO Új fogyasztói ár],	
			[TESCO Új beszerzési ár],	
			[Érvényességi dátum kezdete])
SELECT 
           ' + CAST(@FileLoadId AS NVARCHAR(100)) + ',
			[TPN],	
			[Megnevezés],	
			[Forgalmazó],	
			[Új fogyasztói ár],	
			[Új beszerzési ár],	
			[TESCO Új fogyasztói ár],	
			[TESCO Új beszerzési ár],	
			[Érvényességi dátum kezdete]

FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.12.0''
	,''Excel 12.0;Database=' + @Path + ';HDR=YES''
	,''SELECT * FROM [árváltozás$A2:Z]'')
WHERE 
			[TPN] IS NOT NULL
	'

EXEC (@SQL)

RETURN 0