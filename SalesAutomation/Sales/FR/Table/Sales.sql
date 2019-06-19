CREATE TABLE [FR].[Sales]
(
	[SalesId] INT IDENTITY(1,1) NOT NULL,
	[ProductId] INT NOT NULL,
	[StoreId] INT NOT NULL,
	[EventDate] DATE NOT NULL,
	[Number] INT NOT NULL,
	[CostPrice] FLOAT NOT NULL,
	[ValueCostPrice] FLOAT NOT NULL,
	[PriceMargin] FLOAT NOT NULL,
	[NetSales] FLOAT NOT NULL,
	[BrutSales] INT NOT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_FR_Sales_SalesId] PRIMARY KEY ([SalesId]),
    CONSTRAINT [FK_FR_Sales_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES dbo.Product([ProductId]),
    CONSTRAINT [FK_FR_Sales_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES dbo.Store([StoreId]) 
)

GO

CREATE TRIGGER [dbo].[TR_FR_Sales_SetValueForUpdatedUTC]
    ON FR.Sales
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE FR.Sales
		SET UpdatedUTC = GETUTCDATE()
		WHERE SalesId IN (select SalesId from Inserted)
    END