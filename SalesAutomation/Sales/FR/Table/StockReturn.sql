CREATE TABLE [FR].[StockReturn]
(
	[StockReturnId] INT IDENTITY(1,1) NOT NULL,
	[Staging_StockReturnId] INT NOT NULL,
	[ProductId] INT NOT NULL,
	[StoreId] INT NOT NULL,
	[EventDate] DATE NOT NULL,
	[Number] INT NOT NULL,
	[CostUnitPrice] FLOAT NULL,
	[ValueCostPrice] FLOAT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_FR_StockReturn_StockReturnId] PRIMARY KEY (StockReturnId), 
    CONSTRAINT [FK_FR_StockReturn_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES dbo.Product([ProductId]),
    CONSTRAINT [FK_FR_StockReturn_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES dbo.Store([StoreId]), 
    CONSTRAINT [FK_FR_StockReturn_FR_Staging_StockReturn] FOREIGN KEY ([Staging_StockReturnId]) REFERENCES FR.Staging_StockReturn([Staging_StockReturnId])
)

GO

CREATE TRIGGER FR.[TR_FR_StockReturn_SetValueForUpdatedUTC]
    ON FR.StockReturn
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE FR.StockReturn
		SET UpdatedUTC = GETUTCDATE()
		WHERE StockReturnId IN (select StockReturnId from Inserted)
    END

