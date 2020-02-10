CREATE TABLE [FR].[Staging_StockLoading] (
    [Staging_StockLoadingId] INT            IDENTITY (1, 1) NOT NULL,
    [FileLoadId]             INT            NOT NULL,
    [tpn]                    BIGINT         NOT NULL,
    [Product]                NVARCHAR (500) NULL,
    [date_e]                 DATE           NULL,
    [corr]                   NVARCHAR (500) NULL,
    [KészletMennyiség]       INT            NULL,
    [BeszEgységár]           FLOAT (53)     NULL,
    [ÉrtékOnktgAron]         FLOAT (53)     NULL,
    [date]                   DATE           NOT NULL,
    [site]                   INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Staging_StockLoadingId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_FR_Staging_StockLoading_FileLoadId]
    ON [FR].[Staging_StockLoading]([FileLoadId] ASC);

