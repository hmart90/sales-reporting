CREATE PROCEDURE [dbo].[MigrateSalesMSTRStagingData]
	@Filepath as nvarchar(400),
	@StockFileType nvarchar(100)
AS
	
	INSERT INTO [dbo].[SalesMSTR]
           ([Local TPN item TPN]
           ,[Local TPN item Long description]
           ,[Local TPN item Primary EAN]
           ,[Local Active supplier Code]
           ,[Local Active supplier Long description]
           ,[Local Store Store code]
           ,[Local Store Store name]
           ,[Day]
           ,[Fiscal week]
           ,[Sold units]
		   ,[Sales excl VAT]
           ,[Scan margin]
           ,[Type]
           ,[Filename])
	SELECT [F1]
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
		  ,[F12]
		  ,@StockFileType
		  ,@Filepath
	  FROM [dbo].SalesMSTRStaging

RETURN 0
