CREATE TABLE [dbo].[StockMSTRWEEKLY]
(
	[StockMSTRId] BIGINT identity(1,1) NOT NULL PRIMARY KEY, 
    [Local TPN item TPN] BIGINT NULL, 
    [Local TPN item Long description] NVARCHAR(1000) NULL,
    [Local TPN item Primary EAN] BIGINT NULL, 
    [Local TPN item Status] NCHAR(1) NULL,
    [Local Active supplier Code] INT NULL, 
    [Local Active supplier Long description] NVARCHAR(1000) NULL, 
    [Local Store Store code] INT NULL, 
    [Local Store Store name] NVARCHAR(1000) NULL, 
    [Day] DATE NULL, 
    [Fiscal week] NVARCHAR(8) NULL, 
    [Stock units (Daily Shops)] FLOAT NULL, 
    [Total Stock value Daily (cost price)] FLOAT NULL, 
    [Type] NVARCHAR(10) NULL 
  )  
GO
