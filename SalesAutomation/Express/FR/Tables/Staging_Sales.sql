CREATE TABLE [FR].[Staging_Sales] (
    [Staging_SalesId]              INT            IDENTITY (1, 1) NOT NULL,
    [FileLoadId]                   INT            NOT NULL,
    [Div]                          INT            NOT NULL,
    [Dep]                          INT            NOT NULL,
    [Sec]                          INT            NOT NULL,
    [Grp]                          INT            NOT NULL,
    [Sgrp]                         INT            NOT NULL,
    [TPN]                          BIGINT         NOT NULL,
    [Description]                  NVARCHAR (500) NOT NULL,
    [Értékesített készlet (db)]    INT            NOT NULL,
    [Beszerzési Egységár]          FLOAT (53)     NOT NULL,
    [Értékesített készlet (érték)] FLOAT (53)     NOT NULL,
    [Árrés]                        FLOAT (53)     NOT NULL,
    [Nettó Árbevétel]              FLOAT (53)     NOT NULL,
    [Bruttó Árbevétel]             INT            NOT NULL,
    [Dátum]                        DATE           NOT NULL,
    [Site]                         INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Staging_SalesId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_FR_Staging_Sales_FileLoadId]
    ON [FR].[Staging_Sales]([FileLoadId] ASC);

