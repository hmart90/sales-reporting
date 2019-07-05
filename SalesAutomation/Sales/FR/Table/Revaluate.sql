CREATE TABLE [FR].[Revaluate]
(
	[RevaluateId] INT IDENTITY(1,1) NOT NULL,
	[Staging_RevaluateId] INT NOT NULL,
	[ProductId] INT NOT NULL,
	[StoreId] INT NOT NULL,
	[EventDate] DATE NOT NULL,
	[Number] INT NULL,
	[ValueCostPrice] FLOAT NULL,
	[CorrectedBy] NVARCHAR(500) NULL,
	[ReasonCode] NVARCHAR(500) NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_FR_Revaluate_RevaluateId] PRIMARY KEY (RevaluateId), 
    CONSTRAINT [FK_FR_Revaluate_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES dbo.Product([ProductId]),
    CONSTRAINT [FK_FR_Revaluate_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES dbo.Store([StoreId]),
    CONSTRAINT [FK_FR_Revaluate_FR_Staging_Revaluate] FOREIGN KEY ([Staging_RevaluateId]) REFERENCES FR.Staging_Revaluate([Staging_RevaluateId])
)

GO

CREATE TRIGGER FR.[TR_FR_Revaluate_SetValueForUpdatedUTC]
    ON FR.Revaluate
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE FR.Revaluate
		SET UpdatedUTC = GETUTCDATE()
		WHERE RevaluateId IN (select RevaluateId from Inserted)
    END

