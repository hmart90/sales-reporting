CREATE TABLE [dbo].[Product]
(
	[ProductId] INT IDENTITY(1,1) NOT NULL,
	[SupplierId] INT NOT NULL,
	[SubSupplierId] INT NULL,
	[TPN] BIGINT NOT NULL,
	[EAN] BIGINT NULL,
	[TitleHU] NVARCHAR(1000) NULL,
	[TitleEN] NVARCHAR(1000) NULL,
	[Category] NVARCHAR(20) NOT NULL,
	[StoreConnection] INT NULL,
	[Space] NVARCHAR(100) NULL,
	[IsAutoCreated] BIT NOT NULL DEFAULT(0),
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_dbo_Product] PRIMARY KEY ([ProductId]), 
    CONSTRAINT [FK_dbo_Product_dbo_Supplier] FOREIGN KEY ([SupplierId]) REFERENCES dbo.Supplier([SupplierId]), 
    CONSTRAINT [FK_dbo_Product_dbo_SubSupplier] FOREIGN KEY ([SubSupplierId]) REFERENCES dbo.SubSupplier([SubSupplierId])
)
GO

CREATE TRIGGER [dbo].[TR_dbo_Product_SetValueForUpdatedUTC]
    ON [dbo].Product
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE dbo.Product
		SET UpdatedUTC = GETUTCDATE()
		WHERE ProductId IN (select ProductId from Inserted)
    END