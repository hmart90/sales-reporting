CREATE TABLE [MSTR].[Sales] (
    [SalesId]         INT           IDENTITY (1, 1) NOT NULL,
    [Staging_SalesId] INT           NOT NULL,
    [ProductId]       INT           NOT NULL,
    [StoreId]         INT           NOT NULL,
    [EventDate]       DATE          NOT NULL,
    [Number]          INT           NOT NULL,
    [SalesExclVAT]    FLOAT (53)    NOT NULL,
    [Margin]          FLOAT (53)    NOT NULL,
    [InsertedUTC]     DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]      DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_MSTR_Sales] PRIMARY KEY CLUSTERED ([SalesId] ASC),
    CONSTRAINT [FK_MSTR_Sales_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId]),
    CONSTRAINT [FK_MSTR_Sales_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES [dbo].[Store] ([StoreId]),
    );


GO