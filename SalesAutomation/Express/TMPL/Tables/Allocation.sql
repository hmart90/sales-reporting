CREATE TABLE [TMPL].[Allocation] (
    [AllocationId]        INT           IDENTITY (1, 1) NOT NULL,
    [OrderProductCountId] INT           NOT NULL,
    [StoreId]             INT           NOT NULL,
    [Number]              INT           NOT NULL,
    [Stock]               INT           DEFAULT ((0)) NOT NULL,
    [TargetNumber]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [StoreShare]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [InsertedUTC]         DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]          DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_TMPL_Allocation] PRIMARY KEY CLUSTERED ([AllocationId] ASC),
    CONSTRAINT [FK_TMPL_Allocation_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES [dbo].[Store] ([StoreId]),
    CONSTRAINT [FK_TMPL_Allocation_TMPL_OrderProductCount] FOREIGN KEY ([OrderProductCountId]) REFERENCES [TMPL].[OrderProductCount] ([OrderProductCountId])
);


GO
