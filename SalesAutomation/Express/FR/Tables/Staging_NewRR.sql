CREATE TABLE [FR].[Staging_NewRR] (
    [Staging_NewRRId]      INT            IDENTITY (1, 1) NOT NULL,
    [FileLoadId]           INT            NOT NULL,
    [Site]                 FLOAT (53)     NULL,
    [Receiving number]     FLOAT (53)     NULL,
    [Supplier]             FLOAT (53)     NULL,
    [Original Supplier ID] FLOAT (53)     NULL,
    [Dept]                 FLOAT (53)     NULL,
    [Status]               NVARCHAR (255) NULL,
    [Receiving date]       FLOAT (53)     NULL,
    [Processed date]       FLOAT (53)     NULL,
    [Order number]         FLOAT (53)     NULL,
    [DISPATCH]             FLOAT (53)     NULL,
    [TPN]                  FLOAT (53)     NULL,
    [TPN_]                 FLOAT (53)     NULL,
    [TPN Description]      NVARCHAR (255) NULL,
    [Div]                  FLOAT (53)     NULL,
    [Dep]                  FLOAT (53)     NULL,
    [Sec]                  FLOAT (53)     NULL,
    [QTY]                  FLOAT (53)     NULL,
    [Value]                FLOAT (53)     NULL,
    [Orig_S]               NVARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([Staging_NewRRId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_FR_Staging_NewRR_FileLoadId]
    ON [FR].[Staging_NewRR]([FileLoadId] ASC);

