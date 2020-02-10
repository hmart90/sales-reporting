CREATE TABLE [TMPL].[Order] (
    [OrderId]     INT           IDENTITY (1, 1) NOT NULL,
    [EventDate]   DATE          NOT NULL,
    [IsActive]    BIT           DEFAULT ((1)) NOT NULL,
    [InsertedUTC] DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]  DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_TMPL_Order] PRIMARY KEY CLUSTERED ([OrderId] ASC)
);


GO