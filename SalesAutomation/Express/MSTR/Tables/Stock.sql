CREATE TABLE [MSTR].[Stock] (
    [StockId]         INT           IDENTITY (1, 1) NOT NULL,
    [Staging_StockId] INT           NOT NULL,
    [ProductId]       INT           NOT NULL,
    [StoreId]         INT           NOT NULL,
    [EventDate]       DATE          NOT NULL,
    [Number]          INT           DEFAULT ((0)) NOT NULL,
    [CostPriceValue]  FLOAT (53)    NOT NULL,
    [InsertedUTC]     DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]      DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_MSTR_Stock] PRIMARY KEY CLUSTERED ([StockId] ASC),
    CONSTRAINT [FK_MSTR_Stock_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId]),
    CONSTRAINT [FK_MSTR_Stock_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES [dbo].[Store] ([StoreId])
);


GO
CREATE NONCLUSTERED INDEX [IX_MSTR_Stock_ProductId_StoreId_EventDate]
    ON [MSTR].[Stock]([ProductId] ASC, [StoreId] ASC, [EventDate] ASC);


GO

CREATE TRIGGER MSTR.[TR_MSTR_Stock_SetValueForUpdatedUTC]
    ON MSTR.Stock
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE MSTR.Stock
		SET UpdatedUTC = GETUTCDATE()
		WHERE StockId IN (select StockId from Inserted)
    END