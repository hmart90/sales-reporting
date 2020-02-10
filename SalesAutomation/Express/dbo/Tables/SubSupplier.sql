CREATE TABLE [dbo].[SubSupplier] (
    [SubSupplierId]  INT            IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (100) NOT NULL,
    [IsConsignement] BIT            DEFAULT ((1)) NOT NULL,
    [Margin]         FLOAT (53)     NULL,
    [TescoCode]      INT            NULL,
    [TescoName]      NVARCHAR (500) NULL,
    [IsAutoCreated]  BIT            DEFAULT ((0)) NOT NULL,
    [InsertedUTC]    DATETIME2 (7)  DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]     DATETIME2 (7)  DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_dbo_SubSupplier] PRIMARY KEY CLUSTERED ([SubSupplierId] ASC)
);


GO