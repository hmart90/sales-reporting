CREATE TABLE [FR].[Staging_StockMoving] (
    [Staging_StockMovingId] INT            IDENTITY (1, 1) NOT NULL,
    [FileLoadId]            INT            NOT NULL,
    [site]                  INT            NOT NULL,
    [tpn]                   BIGINT         NOT NULL,
    [Product]               NVARCHAR (500) NOT NULL,
    [date_e]                DATE           NOT NULL,
    [corr]                  NVARCHAR (500) NULL,
    [KészletMennyiség]      INT            NOT NULL,
    [BeszEgységár]          FLOAT (53)     NULL,
    [ÉrtékOnktgAron]        FLOAT (53)     NULL,
    [date]                  DATE           NOT NULL,
    [Comment]               NVARCHAR (500) NOT NULL,
    PRIMARY KEY CLUSTERED ([Staging_StockMovingId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_FR_Staging_StockMoving_FileLoadId]
    ON [FR].[Staging_StockMoving]([FileLoadId] ASC);

