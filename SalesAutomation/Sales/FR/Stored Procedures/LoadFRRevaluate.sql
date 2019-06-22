CREATE PROCEDURE [FR].[LoadFRRevaluate]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0)
DECLARE @SQL AS NVARCHAR(MAX)

SET @SQL = '
INSERT INTO [FR].[Staging_Revaluate]
           ([FileLoadId],
			[tpn],
			[Product],
			[date],
			[Corrected by],
			[KészletMennyiség],
			[ÉrtékOnktgAron],
			[Reason code],
			[site])
SELECT 
           ' + CAST(@FileLoadId AS NVARCHAR(100)) + ',
			[tpn],
			[Product],
			[date],
			[Corrected by],
			[KészletMennyiség],
			[ÉrtékOnktgAron],
			[Reason code],
			[site]

FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.12.0''
	,''Excel 12.0;Database=' + @Path + ';HDR=YES''
	,''SELECT * FROM [Átértékelés$A1:Z]'')
WHERE [tpn] != 0 AND [date] IS NOT NULL
'

EXEC (@SQL)

RETURN 0
