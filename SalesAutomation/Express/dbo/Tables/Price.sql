CREATE TABLE [dbo].[Price] (
    [PriceId]             INT           IDENTITY (1, 1) NOT NULL,
    [Staging_PriceId]     INT           NULL,
    [ProductId]           INT           NOT NULL,
    [StartDate]           DATE          NOT NULL,
    [EndDate]             DATE          NULL,
    [SupplierRetailPrice] FLOAT (53)    NOT NULL,
    [SupplierCostPrice]   FLOAT (53)    NOT NULL,
    [TescoRetailPrice]    FLOAT (53)    NOT NULL,
    [TescoCostPrice]      FLOAT (53)    NOT NULL,
    [InsertedUTC]         DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]          DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_dbo_Price] PRIMARY KEY CLUSTERED ([PriceId] ASC),
    CONSTRAINT [FK_dbo_Price_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId]),
    );


GO