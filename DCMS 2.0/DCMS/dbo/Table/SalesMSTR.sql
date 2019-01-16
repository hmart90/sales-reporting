CREATE TABLE [dbo].[SalesMSTR]
(
	[SalesMSTRId] BIGINT identity(1,1) NOT NULL PRIMARY KEY, 
    [Local TPN item TPN] BIGINT NULL, 
    [Local TPN item Long description] NVARCHAR(300) NOT NULL,
    [Local TPN item Primary EAN] BIGINT NULL, 
    [Local Active supplier Code] INT NULL, 
    [Local Active supplier Long description] NVARCHAR(300) NULL, 
    [Local Store Store code] INT NOT NULL, 
    [Local Store Store name] NVARCHAR(100) NOT NULL, 
    [Day] DATE NOT NULL, 
    [Fiscal week] NVARCHAR(8) NOT NULL, 
    [Sold units] FLOAT NULL, 
    [Sales excl VAT] FLOAT NULL,
	[Scan margin] FLOAT NULL,
    [Type] NVARCHAR(10) NULL, 
    [Filename] NCHAR(100) NULL, 
    [UpdatedUTC] DATETIME NULL
)
GO

CREATE TRIGGER dbo.SalesMSTRUpdatedUTC
ON dbo.[SalesMSTR]
AFTER INSERT
AS 
BEGIN
UPDATE dbo.SalesMSTR
SET UpdatedUTC = GETUTCDATE()
WHERE SalesMSTRId IN (select SalesMSTRId from Inserted)

END