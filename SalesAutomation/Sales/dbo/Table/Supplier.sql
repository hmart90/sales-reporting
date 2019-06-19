CREATE TABLE [dbo].[Supplier]
(
	[SupplierId] INT IDENTITY(1,1) NOT NULL,
	[Name] NVARCHAR(100) NOT NULL,
	[IsConsignement] BIT NOT NULL DEFAULT(1),
	[Margin] FLOAT NOT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_dbo_Supplier] PRIMARY KEY ([SupplierId])
)
GO

CREATE TRIGGER [dbo].[TR_dbo_Supplier_SetValueForUpdatedUTC]
    ON [dbo].Supplier
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE dbo.Supplier
		SET UpdatedUTC = GETUTCDATE()
		WHERE SupplierId IN (select SupplierId from Inserted)
    END