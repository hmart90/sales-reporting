CREATE TABLE [FR].[Staging_StockClosing] (
    [Staging_StockClosingId] INT            IDENTITY (1, 1) NOT NULL,
    [FileLoadId]             INT            NOT NULL,
    [Div]                    INT            NOT NULL,
    [Dep]                    INT            NOT NULL,
    [Sec]                    INT            NOT NULL,
    [TPN]                    BIGINT         NOT NULL,
    [Description]            NVARCHAR (500) NOT NULL,
    [Státusz]                NVARCHAR (10)  NOT NULL,
    [KészletMennyiség]       INT            NULL,
    [BeszEgységár]           FLOAT (53)     NULL,
    [ÉrtékOnktgAron]         FLOAT (53)     NULL,
    [ÉrtékFogyAron]          FLOAT (53)     NULL,
    [Site]                   INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Staging_StockClosingId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_FR_Staging_StockClosing_FileLoadId]
    ON [FR].[Staging_StockClosing]([FileLoadId] ASC);

