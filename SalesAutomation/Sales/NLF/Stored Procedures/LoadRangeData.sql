CREATE PROCEDURE [NLF].[LoadRangeData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);
DECLARE @SQL AS NVARCHAR(MAX);
SET @SQL = '
INSERT INTO [NLF].[Staging_Range]
           ([FileLoadId],
			[gyártó/forgalmazó],
			[brand/stúdió],
			[EAN],
			[TPN],
			["megnevezés (borítócím/teljes terméknév)"],
			[kategória (DVD/Gaming)],
			["választék (cat1-5)"],
			[Store number],
			["space (normal mod/ END/ FSDU)"],
			[range hónap],
			[fogyár])
SELECT 
           ' + CAST(@FileLoadId AS NVARCHAR(100)) + ',
	[gyártó/forgalmazó],
	[brand/stúdió],
	[EAN],
	[TPN],
	[megnevezés_ (borítócím/teljes terméknév)],
	[kategória (DVD/Gaming)],
	[választék _(cat1-5)],
	[Store number],
	[space _(normal mod/ END/ FSDU)],
	[range hónap],
	[fogyár]

FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.12.0''
	,''Excel 12.0;Database=' + @Path + ';HDR=YES''
	,''SELECT * FROM [Munka1$A1:Z]'')
WHERE [TPN] IS NOT NULL AND cast([TPN] as nvarchar(1000)) != ''#N/A''
		AND [range hónap] IS NOT NULL
		AND [Store number] IS NOT NULL
	
'

EXEC (@SQL)

RETURN 0
