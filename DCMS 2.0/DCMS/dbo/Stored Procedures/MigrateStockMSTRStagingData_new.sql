CREATE PROCEDURE [dbo].[MigrateStockMSTRStagingData_new]
	@Filepath as nvarchar(400),
	@StockFileType nvarchar(100)
AS
	
	INSERT INTO [dbo].[StockMSTR]
           ([Local TPN item TPN]
           ,[Local TPN item Long description]
           ,[Local TPN item Primary EAN]
           ,[Local TPN item Status]
           ,[Sca Pack Qty]
           ,[Local Active supplier Code]
           ,[Local Active supplier Long description]
           ,[Local Store Store code]
           ,[Local Store Store name]
           ,[Day]
           ,[Fiscal week]
           ,[Stock units (Daily Shops)]
           ,[Total Stock value Daily (cost price)]
           ,[Type]
           ,[Filename])
	SELECT [F1]
		  ,[F2]
		  ,[F3]
		  ,[F4]
		  ,'1'
		  ,[F6]
		  ,[F7]
		  ,[F8]
		  ,[F9]
		  ,[F10]
		  ,[F11]
		  ,[F12]
		  ,[F13]
		  ,@StockFileType
		  ,@Filepath
	  FROM [dbo].StockMSTRStaging_new

RETURN 0
