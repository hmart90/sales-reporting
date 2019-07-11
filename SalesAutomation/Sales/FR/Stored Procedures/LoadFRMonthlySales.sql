CREATE PROCEDURE [FR].[LoadFRMonthlySales]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0)
DECLARE @SQL AS NVARCHAR(MAX)

SET @SQL = '
INSERT INTO [FR].[Staging_MonthlySales]
           ([FileLoadId],
			[TPN],
			[Div],
			[Dep],
			[Sec],
			[Grp],
			[Sgrp],
			[Description],
			[Értékesített készlet (db)],
			[Beszerzési Egységár],
			[Értékesített készlet (érték)],
			[Árrés],
			[Nettó Árbevétel],
			[Bruttó Árbevétel],
			[Dátum],
			[Site])

SELECT 
           ' + CAST(@FileLoadId AS NVARCHAR(100)) + ',
			[TPN],
			[Div],
			[Dep],
			[Sec],
			[Grp],
			[Sgrp],
			[Description],
			[Értékesített készlet (db)],
			[Beszerzési Egységár],
			[Értékesített készlet (érték)],
			[Árrés],
			[Nettó Árbevétel],
			[Bruttó Árbevétel],
			[Dátum],
			[Site]

FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.12.0''
	,''Excel 12.0;Database=' + @Path + ';HDR=YES''
	,''SELECT * FROM [Eladás$A1:Z]'')
WHERE [TPN] IS NOT NULL
'

EXEC (@SQL)

RETURN 0
