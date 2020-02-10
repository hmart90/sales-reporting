CREATE TABLE [MSTR].[Staging_Stock] (
    [Staging_StockId]                        INT             IDENTITY (1, 1) NOT NULL,
    [FileLoadId]                             INT             NOT NULL,
    [Local TPN item TPN]                     BIGINT          NOT NULL,
    [Local TPN item Long description]        NVARCHAR (1000) NULL,
    [Local TPN item Primary EAN]             BIGINT          NULL,
    [Local Active supplier Code]             BIGINT          NULL,
    [Local Active supplier Long description] NVARCHAR (1000) NULL,
    [Local Store Store code]                 BIGINT          NOT NULL,
    [Local Store Store name]                 NVARCHAR (1000) NULL,
    [Day]                                    DATE            NOT NULL,
    [Fiscal week]                            NVARCHAR (100)  NOT NULL,
    [Stock units (Daily Shops)]              INT             NULL,
    [Total Stock value Daily (cost price)]   FLOAT (53)      NOT NULL,
    CONSTRAINT [PK_MSTR_Staging_Stock] PRIMARY KEY CLUSTERED ([Staging_StockId] ASC),
    CONSTRAINT [FK_MSTR_Staging_Stock_FileLoad_FileLoadId] FOREIGN KEY ([FileLoadId]) REFERENCES [dbo].[FileLoad] ([FileLoadId])
);


GO
CREATE NONCLUSTERED INDEX [IX_MSTR_Staging_Stock_FileLoadId]
    ON [MSTR].[Staging_Stock]([FileLoadId] ASC);

