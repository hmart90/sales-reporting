CREATE TABLE [dbo].[Product] (
    [ProductId]       INT             IDENTITY (1, 1) NOT NULL,
    [SupplierId]      INT             NOT NULL,
    [SubSupplierId]   INT             NULL,
    [TPN]             BIGINT          NOT NULL,
    [EAN]             BIGINT          NULL,
    [TitleHU]         NVARCHAR (1000) NULL,
    [TitleEN]         NVARCHAR (1000) NULL,
    [Category]        NVARCHAR (20)   NOT NULL,
    [StoreConnection] INT             NULL,
    [Space]           NVARCHAR (100)  NULL,
    [IsAutoCreated]   BIT             DEFAULT ((0)) NOT NULL,
    [InsertedUTC]     DATETIME2 (7)   DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]      DATETIME2 (7)   DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_dbo_Product] PRIMARY KEY CLUSTERED ([ProductId] ASC),
    CONSTRAINT [FK_dbo_Product_dbo_SubSupplier] FOREIGN KEY ([SubSupplierId]) REFERENCES [dbo].[SubSupplier] ([SubSupplierId]),
    CONSTRAINT [FK_dbo_Product_dbo_Supplier] FOREIGN KEY ([SupplierId]) REFERENCES [dbo].[Supplier] ([SupplierId]),
    CONSTRAINT [AK_dbo_Product_TPN] UNIQUE NONCLUSTERED ([TPN] ASC)
);


GO
