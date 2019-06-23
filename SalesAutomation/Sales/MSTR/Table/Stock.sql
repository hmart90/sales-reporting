CREATE TABLE [MSTR].[Stock]
(
	[StockId] INT IDENTITY(1,1) NOT NULL,
	[ProductId] INT NOT NULL,
	[StoreId] INT NOT NULL,
	[EventDate] DATE NOT NULL,
	[Number] INT NOT NULL DEFAULT 0,
	[CostPriceValue] FLOAT NOT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_MSTR_Stock] PRIMARY KEY ([StockId]), 
    CONSTRAINT [FK_MSTR_Stock_dbo_Product] FOREIGN KEY (ProductId) REFERENCES dbo.Product(ProductId),
    CONSTRAINT [FK_MSTR_Stock_dbo_Store] FOREIGN KEY (StoreId) REFERENCES dbo.Store(StoreId)
)
GO

CREATE TRIGGER MSTR.[TR_MSTR_Stock_SetValueForUpdatedUTC]
    ON MSTR.Stock
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE MSTR.Stock
		SET UpdatedUTC = GETUTCDATE()
		WHERE StockId IN (select StockId from Inserted)
    END
