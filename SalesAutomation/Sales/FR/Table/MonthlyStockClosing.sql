CREATE TABLE [FR].[MonthlyStockClosing]
(
	[MonthlyStockClosingId] INT IDENTITY(1,1) NOT NULL,
	[Staging_MonthlyStockClosingId] INT NOT NULL,
	[ProductId] INT NOT NULL,
	[StoreId] INT NOT NULL,
	[EventDate] DATE NOT NULL,
	[Number] INT NOT NULL,
	[CostUnitPrice] FLOAT NULL,
	[ValueCostPrice] FLOAT NULL,
	[ValueRetailPrice] FLOAT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_FR_MonthlyStockClosing_StockClosingId] PRIMARY KEY (MonthlyStockClosingId), 
    CONSTRAINT [FK_FR_MonthlyStockClosing_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES dbo.Product([ProductId]),
    CONSTRAINT [FK_FR_MonthlyStockClosing_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES dbo.Store([StoreId]),
    CONSTRAINT [FK_FR_MonthlyStockClosing_FR_Staging_MonthlyStockClosing] FOREIGN KEY ([Staging_MonthlyStockClosingId]) REFERENCES FR.Staging_MonthlyStockClosing([Staging_MonthlyStockClosingId])
)

GO

CREATE TRIGGER FR.[TR_FR_MonthlyStockClosing_SetValueForUpdatedUTC]
    ON FR.MonthlyStockClosing
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE FR.MonthlyStockClosing
		SET UpdatedUTC = GETUTCDATE()
		WHERE MonthlyStockClosingId IN (select MonthlyStockClosingId from Inserted)
    END