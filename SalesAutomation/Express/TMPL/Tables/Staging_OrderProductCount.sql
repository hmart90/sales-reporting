CREATE TABLE [TMPL].[Staging_OrderProductCount] (
    [Staging_OrderProductCountId] INT             IDENTITY (1, 1) NOT NULL,
    [FileLoadId]                  INT             NOT NULL,
    [TPN]                         BIGINT          NOT NULL,
    [Description]                 NVARCHAR (1000) NULL,
    [Normal price]                FLOAT (53)      NULL,
    [Cost price (Tesco)]          FLOAT (53)      NULL,
    [Cost price in GBP]           FLOAT (53)      NULL,
    [Quantity]                    INT             NOT NULL,
    [Min]                         INT             DEFAULT ((1)) NOT NULL,
    [Max]                         INT             DEFAULT ((7)) NOT NULL,
    CONSTRAINT [PK_TMPL_Staging_OrderProductCount] PRIMARY KEY CLUSTERED ([Staging_OrderProductCountId] ASC),
    CONSTRAINT [FK_TMPL_Staging_OrderProductCount_FileLoad_FileLoadId] FOREIGN KEY ([FileLoadId]) REFERENCES [dbo].[FileLoad] ([FileLoadId])
);


GO
CREATE NONCLUSTERED INDEX [IX_TMPL_Staging_OrderProductCount_FileLoadId]
    ON [TMPL].[Staging_OrderProductCount]([FileLoadId] ASC);

