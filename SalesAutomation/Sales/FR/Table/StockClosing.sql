CREATE TABLE [FR].[StockClosing]
(
	[StockClosingId] INT IDENTITY(1,1) NOT NULL,
	[ProductId] INT NOT NULL,
	[StoreId] INT NOT NULL,
	[EventDate] DATE NOT NULL,
	[Number] INT NOT NULL,
	[CostUnitPrice] FLOAT NULL,
	[ValueCostPrice] FLOAT NULL,
	[ValueRetailPrice] FLOAT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_FR_StockClosing_StockClosingId] PRIMARY KEY (StockClosingId), 
    CONSTRAINT [FK_FR_StockClosing_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES dbo.Product([ProductId]),
    CONSTRAINT [FK_FR_StockClosing_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES dbo.Store([StoreId])
)

GO

CREATE TRIGGER FR.[TR_FR_StockClosing_SetValueForUpdatedUTC]
    ON FR.StockClosing
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE FR.StockClosing
		SET UpdatedUTC = GETUTCDATE()
		WHERE StockClosingId IN (select StockClosingId from Inserted)
    END