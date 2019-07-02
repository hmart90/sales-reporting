CREATE TABLE [TMPL].[Allocation]
(
	[AllocationId] INT IDENTITY(1,1) NOT NULL,
	[OrderProductCountId] INT NOT NULL,
	[StoreId] INT NOT NULL,
	[Number] INT NOT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_TMPL_Allocation] PRIMARY KEY ([AllocationId]),
    CONSTRAINT [FK_TMPL_Allocation_TMPL_OrderProductCount] FOREIGN KEY ([OrderProductCountId]) REFERENCES TMPL.[OrderProductCount]([OrderProductCountId]),
    CONSTRAINT [FK_TMPL_Allocation_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES dbo.Store([StoreId])
)
GO

CREATE TRIGGER TMPL.[TR_TMPL_Allocation_SetValueForUpdatedUTC]
    ON TMPL.Allocation
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE TMPL.Allocation
		SET UpdatedUTC = GETUTCDATE()
		WHERE [AllocationId] IN (select [AllocationId] from Inserted)
    END

