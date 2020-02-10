CREATE TABLE [FR].[StockLoading] (
    [StockLoadingId]         INT           IDENTITY (1, 1) NOT NULL,
    [Staging_StockLoadingId] INT           NOT NULL,
    [ProductId]              INT           NOT NULL,
    [StoreId]                INT           NOT NULL,
    [EventDate]              DATE          NOT NULL,
    [Number]                 INT           NOT NULL,
    [CostUnitPrice]          FLOAT (53)    NULL,
    [ValueCostPrice]         FLOAT (53)    NULL,
    [InsertedUTC]            DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]             DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_FR_StockLoading_StockLoadingId] PRIMARY KEY CLUSTERED ([StockLoadingId] ASC),
    CONSTRAINT [FK_FR_StockLoading_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId]),
    CONSTRAINT [FK_FR_StockLoading_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES [dbo].[Store] ([StoreId]),
    );


GO
