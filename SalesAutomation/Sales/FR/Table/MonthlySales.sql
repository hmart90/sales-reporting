CREATE TABLE [FR].[MonthlySales]
(
	[MonthlySalesId] INT IDENTITY(1,1) NOT NULL,
	[Staging_MonthlySalesId] INT NOT NULL,
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
    CONSTRAINT [PK_FR_MonthlySales_MonthlySalesId] PRIMARY KEY ([MonthlySalesId]),
    CONSTRAINT [FK_FR_MonthlySales_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES dbo.Product([ProductId]),
    CONSTRAINT [FK_FR_MonthlySales_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES dbo.Store([StoreId]) ,
    CONSTRAINT [FK_FR_MonthlySales_FR_Staging_MonthlySales] FOREIGN KEY ([Staging_MonthlySalesId]) REFERENCES FR.Staging_MonthlySales([Staging_MonthlySalesId])
)

GO

CREATE TRIGGER FR.[TR_FR_MonthlySales_SetValueForUpdatedUTC]
    ON FR.MonthlySales
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE FR.MonthlySales
		SET UpdatedUTC = GETUTCDATE()
		WHERE MonthlySalesId IN (select MonthlySalesId from Inserted)
    END