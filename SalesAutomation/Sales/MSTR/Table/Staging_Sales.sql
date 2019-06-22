CREATE TABLE [MSTR].[Staging_Sales]
(
	[Staging_SalesId] INT IDENTITY(1,1) NOT NULL,
	[FileLoadId] INT NOT NULL,
	[Local TPN item TPN] BIGINT NOT NULL,
	[Local TPN item Long description] NVARCHAR(1000) NULL,	
	[Local TPN item Primary EAN] BIGINT NULL,
	[Local Active supplier Code] BIGINT NULL,
	[Local Active supplier Long description] NVARCHAR(1000) NULL,
	[Local Store Store code] BIGINT NOT NULL,
	[Local Store Store name] NVARCHAR(1000) NULL,
	[Day] DATE NOT NULL,
	[Fiscal week] NVARCHAR(100) NOT NULL,
	[Sold units] INT NOT NULL,
	[Sales excl VAT] FLOAT NOT NULL,
	[Scan margin] FLOAT NOT NULL, 
    CONSTRAINT [PK_MSTR_Staging_Sales] PRIMARY KEY ([Staging_SalesId]), 
    CONSTRAINT [FK_MSTR_Staging_Sales_FileLoad_FileLoadId] FOREIGN KEY ([FileLoadId]) REFERENCES dbo.FileLoad([FileLoadId])
)
