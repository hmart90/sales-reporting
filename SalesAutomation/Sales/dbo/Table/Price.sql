CREATE TABLE [dbo].[Price]
(
	[PriceId] INT IDENTITY(1,1) NOT NULL,
	[Staging_PriceId] INT NULL,
	[ProductId] INT NOT NULL,
	[StartDate] DATE NOT NULL,
	[EndDate] DATE NULL,
	[SupplierRetailPrice] FLOAT NOT NULL,
	[SupplierCostPrice] FLOAT NOT NULL,
	[TescoRetailPrice] FLOAT NOT NULL,
	[TescoCostPrice] FLOAT NOT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_dbo_Price] PRIMARY KEY ([PriceId]), 
    CONSTRAINT [FK_dbo_Price_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES dbo.Product([ProductId]), 
    CONSTRAINT [FK_dbo_Price_TMPL_Staging_Price] FOREIGN KEY (Staging_PriceId) REFERENCES TMPL.Staging_Price(Staging_PriceId)
)
GO

CREATE TRIGGER [dbo].[TR_dbo_Price_SetValueForUpdatedUTC]
    ON [dbo].Price
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE dbo.Price
		SET UpdatedUTC = GETUTCDATE()
		WHERE PriceId IN (select PriceId from Inserted)
    END
