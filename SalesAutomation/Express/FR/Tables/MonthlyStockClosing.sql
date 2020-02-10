CREATE TABLE [FR].[MonthlyStockClosing] (
    [MonthlyStockClosingId]         INT           IDENTITY (1, 1) NOT NULL,
    [Staging_MonthlyStockClosingId] INT           NOT NULL,
    [ProductId]                     INT           NOT NULL,
    [StoreId]                       INT           NOT NULL,
    [EventDate]                     DATE          NOT NULL,
    [Number]                        INT           NOT NULL,
    [CostUnitPrice]                 FLOAT (53)    NULL,
    [ValueCostPrice]                FLOAT (53)    NULL,
    [ValueRetailPrice]              FLOAT (53)    NULL,
    [InsertedUTC]                   DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]                    DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_FR_MonthlyStockClosing_StockClosingId] PRIMARY KEY CLUSTERED ([MonthlyStockClosingId] ASC),
    CONSTRAINT [FK_FR_MonthlyStockClosing_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId]),
    CONSTRAINT [FK_FR_MonthlyStockClosing_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES [dbo].[Store] ([StoreId]),
);


GO

CREATE TRIGGER FR.[TR_FR_MonthlyStockClosing_SetValueForUpdatedUTC]
    ON FR.MonthlyStockClosing
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE FR.MonthlyStockClosing
		SET UpdatedUTC = GETUTCDATE()
		WHERE MonthlyStockClosingId IN (select MonthlyStockClosingId from Inserted)
    END