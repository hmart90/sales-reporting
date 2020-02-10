CREATE TABLE [TMPL].[OrderProductCount] (
    [OrderProductCountId]         INT           IDENTITY (1, 1) NOT NULL,
    [Staging_OrderProductCountId] INT           NOT NULL,
    [OrderId]                     INT           NOT NULL,
    [ProductId]                   INT           NOT NULL,
    [Number]                      INT           NOT NULL,
    [Min]                         INT           NOT NULL,
    [Max]                         INT           NOT NULL,
    [InsertedUTC]                 DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]                  DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_TMPL_OrderProductCount] PRIMARY KEY CLUSTERED ([OrderProductCountId] ASC),
    CONSTRAINT [FK_TMPL_OrderProductCount_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId]),
    CONSTRAINT [FK_TMPL_OrderProductCount_TMPL_Order] FOREIGN KEY ([OrderId]) REFERENCES [TMPL].[Order] ([OrderId]),
    );


GO