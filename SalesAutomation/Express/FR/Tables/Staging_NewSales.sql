CREATE TABLE [FR].[Staging_NewSales] (
    [Staging_NewSalesId]             INT        IDENTITY (1, 1) NOT NULL,
    [FileLoadId]                     INT        NOT NULL,
    [Site]                           FLOAT (53) NULL,
    [TPN]                            FLOAT (53) NULL,
    [Supplier ID]                    FLOAT (53) NULL,
    [Div]                            FLOAT (53) NULL,
    [Dep]                            FLOAT (53) NULL,
    [Sec]                            FLOAT (53) NULL,
    [Day]                            DATETIME   NULL,
    [Sales QTY]                      FLOAT (53) NULL,
    [Sales at retail price excl VAT] FLOAT (53) NULL,
    [Gross margin]                   FLOAT (53) NULL,
    [Sales at cost price]            FLOAT (53) NULL,
    [VAT rate]                       FLOAT (53) NULL,
    PRIMARY KEY CLUSTERED ([Staging_NewSalesId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_FR_Staging_NewSales_FileLoadId]
    ON [FR].[Staging_NewSales]([FileLoadId] ASC);

