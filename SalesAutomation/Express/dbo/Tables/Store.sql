CREATE TABLE [dbo].[Store] (
    [StoreId]         INT            IDENTITY (1, 1) NOT NULL,
    [Code]            FLOAT (53)     NOT NULL,
    [Name]            NVARCHAR (255) NULL,
    [TypeShortFormat] NVARCHAR (255) NULL,
    [TypeLongFormat]  NVARCHAR (255) NULL,
    [Connection_67]   BIT            NULL,
    [Connection_110]  BIT            NULL,
    [InsertedUTC]     DATETIME2 (7)  DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]      DATETIME2 (7)  DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_dbo_Store] PRIMARY KEY CLUSTERED ([StoreId] ASC)
);


GO
