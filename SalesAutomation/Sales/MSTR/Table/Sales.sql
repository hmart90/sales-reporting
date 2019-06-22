﻿CREATE TABLE [MSTR].[Sales]
(
	[SalesId] INT IDENTITY(1,1) NOT NULL,
	[ProductId] INT NOT NULL,
	[StoreId] INT NOT NULL,
	[EventDate] DATE NOT NULL,
	[Number] INT NOT NULL,
	[SalesExclVAT] FLOAT NOT NULL,
	[Margin] FLOAT NOT NULL, 
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_MSTR_Sales] PRIMARY KEY ([SalesId]), 
    CONSTRAINT [FK_MSTR_Sales_dbo_Product] FOREIGN KEY (ProductId) REFERENCES dbo.Product(ProductId),
    CONSTRAINT [FK_MSTR_Sales_dbo_Store] FOREIGN KEY (StoreId) REFERENCES dbo.Store(StoreId)
)
GO

CREATE TRIGGER MSTR.[TR_MSTR_Sales_SetValueForUpdatedUTC]
    ON MSTR.Sales
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE MSTR.Sales
		SET UpdatedUTC = GETUTCDATE()
		WHERE SalesId IN (select SalesId from Inserted)
    END
