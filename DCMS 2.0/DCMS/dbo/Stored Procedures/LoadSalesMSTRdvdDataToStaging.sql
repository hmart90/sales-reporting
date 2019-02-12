CREATE PROCEDURE dbo.LoadSalesMSTRdvdDataToStaging
	@Filepath as nvarchar(500),
	@SheetName as nvarchar(500)
AS

	declare @sql nvarchar(max);

	set @sql='INSERT INTO [dbo].[SalesMSTRStaging]
           ([F1]
           ,[F2]
           ,[F3]
           ,[F4]
           ,[F5]
           ,[F6]
           ,[F7]
           ,[F8]
           ,[F9]
           ,[F10]
           ,[F11]
           ,[F12])

	SELECT * FROM OPENROWSET(
	''Microsoft.ACE.OLEDB.12.0''
	,''Excel 12.0;Database=' + @Filepath + ';HDR=YES''
	,''SELECT * FROM [' + @SheetName + '$A4:L]'')'

	exec(@sql)

RETURN 


