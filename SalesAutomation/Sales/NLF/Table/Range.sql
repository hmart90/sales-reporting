CREATE TABLE [NLF].[Range]
(
	[RangeId] INT IDENTITY(1,1) NOT NULL,
	[ProductId] INT NOT NULL,
	[ConnectionCount] INT NOT NULL,
	[EventDate] DATE NOT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_NLF_Range] PRIMARY KEY ([RangeId]), 
    CONSTRAINT [FK_NLF_Range_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES dbo.[Product]([ProductId]),
)
GO

CREATE TRIGGER [NLF].[TR_NLF_Range_SetValueForUpdatedUTC]
    ON [NLF].[Range]
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE [NLF].[Range]
		SET UpdatedUTC = GETUTCDATE()
		WHERE [RangeId] IN (select [RangeId] from Inserted)
    END
