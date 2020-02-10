CREATE TABLE [FR].[StockReturn] (
    [StockReturnId]         INT           IDENTITY (1, 1) NOT NULL,
    [Staging_StockReturnId] INT           NOT NULL,
    [ProductId]             INT           NOT NULL,
    [StoreId]               INT           NOT NULL,
    [EventDate]             DATE          NOT NULL,
    [Number]                INT           NOT NULL,
    [CostUnitPrice]         FLOAT (53)    NULL,
    [ValueCostPrice]        FLOAT (53)    NULL,
    [InsertedUTC]           DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]            DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_FR_StockReturn_StockReturnId] PRIMARY KEY CLUSTERED ([StockReturnId] ASC),
    CONSTRAINT [FK_FR_StockReturn_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId]),
    CONSTRAINT [FK_FR_StockReturn_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES [dbo].[Store] ([StoreId]),
);


GO
