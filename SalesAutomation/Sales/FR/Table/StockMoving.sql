CREATE TABLE [FR].[StockMoving]
(
	[StockMovingId] INT IDENTITY(1,1) NOT NULL,
	[ProductId] INT NOT NULL,
	[StoreId] INT NOT NULL,
	[EventDate] DATE NOT NULL,
	[Number] INT NOT NULL,
	[CostUnitPrice] FLOAT NULL,
	[ValueCostPrice] FLOAT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_FR_StockMoving_StockMovingId] PRIMARY KEY (StockMovingId), 
    CONSTRAINT [FK_FR_StockMoving_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES dbo.Product([ProductId]),
    CONSTRAINT [FK_FR_StockMoving_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES dbo.Store([StoreId])
)

GO

CREATE TRIGGER FR.[TR_FR_StockMoving_SetValueForUpdatedUTC]
    ON FR.StockMoving
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE FR.StockMoving
		SET UpdatedUTC = GETUTCDATE()
		WHERE StockMovingId IN (select StockMovingId from Inserted)
    END

