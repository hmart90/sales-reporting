CREATE TABLE [dbo].[SubSupplier]
(
	[SubSupplierId] INT IDENTITY(1,1) NOT NULL,
	[Name] NVARCHAR(100) NOT NULL,
	[IsConsignement] BIT NOT NULL DEFAULT(1),
	[Margin] FLOAT NULL,
	[TescoCode] INT NULL,
	[TescoName] NVARCHAR(500) NULL,
	[IsAutoCreated] BIT NOT NULL DEFAULT(0),
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_dbo_SubSupplier] PRIMARY KEY ([SubSupplierId])
)

GO

CREATE TRIGGER [dbo].[TR_dbo_SubSupplier_SetValueForUpdatedUTC]
    ON [dbo].SubSupplier
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE dbo.SubSupplier
		SET UpdatedUTC = GETUTCDATE()
		WHERE SubSupplierId IN (select SubSupplierId from Inserted)
    END