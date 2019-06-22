CREATE PROCEDURE [FR].[LoadFRClosing]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0)
DECLARE @SQL AS NVARCHAR(MAX)

DECLARE @Type INT;

SET @Type = (SELECT COUNT(TempExcelSheetId) FROM dbo.TempExcelSheet WHERE SheetName LIKE '%rókész%')

IF @Type> 0
SET @SQL = '
INSERT INTO [FR].[Staging_StockClosing]
           ([FileLoadId]
           ,[TPN]
           ,[Description]
           ,[Státusz]
			,[Div]
			,[Dep]
			,[Sec]
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
			,[Div]
			,[Dep]
			,[Sec]
           ,[KészletMennyiség]
           ,[BeszEgységár]
           ,[ÉrtékOnktgAron]
           ,[ÉrtékFogyAron]
           ,[Site]

FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.12.0''
	,''Excel 12.0;Database=' + @Path + ';HDR=YES''
	,''SELECT * FROM [Zárókészlet$A1:Z]'')'
ELSE
SET @SQL = '
INSERT INTO [FR].[Staging_StockClosing]
           ([FileLoadId]
           ,[TPN]
           ,[Description]
           ,[Státusz]
			,[Div]
			,[Dep]
			,[Sec]
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
			,[Div]
			,[Dep]
			,[Sec]
           ,[KészletMennyiség]
           ,[BeszEgységár]
           ,[ÉrtékOnktgAron]
           ,[ÉrtékFogyAron]
           ,[Site]

FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.12.0''
	,''Excel 12.0;Database=' + @Path + ';HDR=YES''
	,''SELECT * FROM [Záró készlet$A1:Z]'')'

EXEC (@SQL)

RETURN 0
