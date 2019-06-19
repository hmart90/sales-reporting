CREATE TABLE [FR].[StockOpening]
(
	[StockOpeningId] INT IDENTITY(1,1) NOT NULL,
	[ProductId] INT NOT NULL,
	[StoreId] INT NOT NULL,
	[EventDate] DATE NOT NULL,
	[Number] INT NOT NULL,
	[CostUnitPrice] FLOAT NULL,
	[ValueCostPrice] FLOAT NULL,
	[ValueRetailPrice] FLOAT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_FR_StockOpening_StockOpeningId] PRIMARY KEY (StockOpeningId), 
    CONSTRAINT [FK_FR_StockOpening_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES dbo.Product([ProductId]),
    CONSTRAINT [FK_FR_StockOpening_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES dbo.Store([StoreId])
)

GO

CREATE TRIGGER [dbo].[TR_FR_StockOpening_SetValueForUpdatedUTC]
    ON FR.StockOpening
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE FR.StockOpening
		SET UpdatedUTC = GETUTCDATE()
		WHERE StockOpeningId IN (select StockOpeningId from Inserted)
    END