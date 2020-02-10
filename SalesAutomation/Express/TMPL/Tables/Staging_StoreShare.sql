CREATE TABLE [TMPL].[Staging_StoreShare] (
    [Staging_StoreShareId] INT        IDENTITY (1, 1) NOT NULL,
    [StoreId]              INT        NOT NULL,
    [Share]                FLOAT (53) NOT NULL,
    [Stock]                INT        DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([Staging_StoreShareId] ASC)
);

