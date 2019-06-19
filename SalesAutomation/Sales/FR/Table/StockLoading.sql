﻿CREATE TABLE [FR].[StockLoading]
(
	[StockLoadingId] INT IDENTITY(1,1) NOT NULL,
	[ProductId] INT NOT NULL,
	[StoreId] INT NOT NULL,
	[EventDate] DATE NOT NULL,
	[Number] INT NOT NULL,
	[CostUnitPrice] FLOAT NULL,
	[ValueCostPrice] FLOAT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_FR_StockLoading_StockLoadingId] PRIMARY KEY (StockLoadingId), 
    CONSTRAINT [FK_FR_StockLoading_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES dbo.Product([ProductId]),
    CONSTRAINT [FK_FR_StockLoading_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES dbo.Store([StoreId])
)

GO

CREATE TRIGGER [dbo].[TR_FR_StockLoading_SetValueForUpdatedUTC]
    ON FR.StockLoading
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE FR.StockLoading
		SET UpdatedUTC = GETUTCDATE()
		WHERE StockLoadingId IN (select StockLoadingId from Inserted)
    END
