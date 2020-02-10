CREATE TABLE [NLF].[Range] (
    [RangeId]         INT           IDENTITY (1, 1) NOT NULL,
    [Staging_RangeId] INT           NOT NULL,
    [ProductId]       INT           NOT NULL,
    [ConnectionCount] INT           NOT NULL,
    [EventDate]       DATE          NOT NULL,
    [Price]           FLOAT (53)    NULL,
    [InsertedUTC]     DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]      DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_NLF_Range] PRIMARY KEY CLUSTERED ([RangeId] ASC),
    CONSTRAINT [FK_NLF_Range_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId]),
    );


GO
