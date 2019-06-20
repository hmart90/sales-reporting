CREATE PROCEDURE [FR].[LoadFROpening]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0)
DECLARE @SQL AS NVARCHAR(MAX)

SET @SQL = '
INSERT INTO [FR].[Staging_StockOpening]
           ([FileLoadId]
           ,[TPN]
           ,[Description]
           ,[Státusz]
           ,[KészletMennyiség]
           ,[BeszEgységár]
           ,[ÉrtékOnktgAron]
           ,[ÉrtékFogyAron]
           ,[Site])
SELECT 
           ' + CAST(@FileLoadId AS NVARCHAR(100)) + '
           ,[TPN]
           ,[Description]
           ,[Státusz]
           ,[KészletMennyiség]
           ,[BeszEgységár]
           ,[ÉrtékOnktgAron]
           ,[ÉrtékFogyAron]
           ,[Site]

FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.12.0''
	,''Excel 12.0;Database=' + @Path + ';HDR=YES''
	,''SELECT * FROM [Nyitó készlet$A1:Z]'')'

EXEC (@SQL)

RETURN 0
