CREATE TABLE [dbo].[StockMSTR]
(
	[StockMSTRId] BIGINT identity(1,1) NOT NULL PRIMARY KEY, 
    [Local TPN item TPN] BIGINT NULL, 
    [Local TPN item Long description] NVARCHAR(300) NOT NULL,
    [Local TPN item Primary EAN] BIGINT NULL, 
    [Local TPN item Status] NCHAR(1) NOT NULL,
	[Sca Pack Qty]  INT NULL,
    [Local Active supplier Code] INT NULL, 
    [Local Active supplier Long description] NVARCHAR(300) NULL, 
    [Local Store Store code] INT NOT NULL, 
    [Local Store Store name] NVARCHAR(100) NOT NULL, 
    [Day] DATE NOT NULL, 
    [Fiscal week] NVARCHAR(8) NOT NULL, 
    [Stock units (Daily Shops)] FLOAT NULL, 
    [Total Stock value Daily (cost price)] FLOAT NULL, 
    [Type] NVARCHAR(10) NULL, 
    [Filename] NCHAR(100) NULL, 
    [UpdatedUTC] DATETIME NULL
)
GO

CREATE TRIGGER dbo.StockMSTRUpdatedUTC
ON dbo.[StockMSTR]
AFTER INSERT
AS 
BEGIN
UPDATE dbo.StockMSTR
SET UpdatedUTC = GETUTCDATE()
WHERE StockMSTRId IN (select StockMSTRId from Inserted)

END