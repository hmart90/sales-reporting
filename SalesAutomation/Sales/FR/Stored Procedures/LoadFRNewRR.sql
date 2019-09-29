CREATE PROCEDURE [FR].[LoadFRNewRR]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0)
DECLARE @SQL AS NVARCHAR(MAX)

SET @SQL = '
INSERT INTO [FR].[Staging_NewRR]
           ([FileLoadId]
           ,[Site]
           ,[Receiving number]
           ,[Supplier]
           ,[Original Supplier ID]
           ,[Dept]
           ,[Status]
           ,[Receiving date]
           ,[Processed date]
           ,[Order number]
           ,[DISPATCH]
           ,[TPN]
           ,[TPN_]
           ,[TPN Description]
           ,[Div]
           ,[Dep]
           ,[Sec]
           ,[QTY]
           ,[Value]
           ,[Orig_S])
SELECT 
           ' + CAST(@FileLoadId AS NVARCHAR(100)) + '
           ,[Site]
           ,[Receiving number]
           ,[Supplier]
           ,[Original Supplier ID]
           ,[Dept]
           ,[Status]
           ,[Receiving date]
           ,[Processed date]
           ,[Order number]
           ,[DISPATCH]
           ,[TPN]
           ,[TPN_]
           ,[TPN Description]
           ,[Div]
           ,[Dep]
           ,[Sec]
           ,[QTY]
           ,[Value]
           ,[Orig_S]

FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.12.0''
	,''Excel 12.0;Database=' + @Path + ';HDR=YES''
	,''SELECT * FROM [Receivings and returns$A3:Z]'')
'

EXEC (@SQL)

RETURN 0
