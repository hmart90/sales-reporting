CREATE TABLE TMPL.[OrderProductCount]
(
	[OrderProductCountId] INT IDENTITY(1,1) NOT NULL,
	[Staging_OrderProductCountId] INT NOT NULL,
	[OrderId] INT NOT NULL,
	[ProductId] INT NOT NULL,
	[Number] INT NOT NULL,
	[Min] INT NOT NULL,
	[Max] INT NOT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_TMPL_OrderProductCount] PRIMARY KEY ([OrderProductCountId]),
    CONSTRAINT [FK_TMPL_OrderProductCount_TMPL_Order] FOREIGN KEY ([OrderId]) REFERENCES TMPL.[Order]([OrderId]),
    CONSTRAINT [FK_TMPL_OrderProductCount_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES dbo.Product([ProductId]), 
    CONSTRAINT [FK_TMPL_OrderProductCount_TMPL_Staging_OrderProductCount] FOREIGN KEY (Staging_OrderProductCountId) REFERENCES TMPL.Staging_OrderProductCount(Staging_OrderProductCountId)
)
GO

CREATE TRIGGER TMPL.[TR_TMPL_OrderProductCount_SetValueForUpdatedUTC]
    ON TMPL.OrderProductCount
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE TMPL.OrderProductCount
		SET UpdatedUTC = GETUTCDATE()
		WHERE OrderProductCountId IN (select OrderProductCountId from Inserted)
    END
