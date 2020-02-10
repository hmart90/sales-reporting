CREATE TABLE [FR].[Staging_NewStock] (
    [Staging_NewStockId]                INT            IDENTITY (1, 1) NOT NULL,
    [FileLoadId]                        INT            NOT NULL,
    [Site]                              FLOAT (53)     NULL,
    [Site name]                         NVARCHAR (255) NULL,
    [Supplier ID]                       FLOAT (53)     NULL,
    [TPN]                               FLOAT (53)     NULL,
    [TPN description]                   NVARCHAR (255) NULL,
    [Last closing stock QTY]            FLOAT (53)     NULL,
    [Receivings QTY]                    FLOAT (53)     NULL,
    [Returns QTY]                       FLOAT (53)     NULL,
    [Returns at COST]                   FLOAT (53)     NULL,
    [Stock adjustments QTY]             FLOAT (53)     NULL,
    [Stock adjustments at value]        FLOAT (53)     NULL,
    [Stock-Take adjustments QTY]        FLOAT (53)     NULL,
    [Stock-Take adjustments at value]   FLOAT (53)     NULL,
    [Transfers OUT QTY]                 FLOAT (53)     NULL,
    [Transfers IN QTY]                  FLOAT (53)     NULL,
    [Sales QTY]                         FLOAT (53)     NULL,
    [Stock in transit QTY]              FLOAT (53)     NULL,
    [Unprocessed movements QTY]         FLOAT (53)     NULL,
    [Closing stock QTY]                 FLOAT (53)     NULL,
    [COGS]                              FLOAT (53)     NULL,
    [Gross margin]                      FLOAT (53)     NULL,
    [Sales at retail incl VAT]          NVARCHAR (255) NULL,
    [VAT]                               FLOAT (53)     NULL,
    [Sales at retail excl VAT]          NVARCHAR (255) NULL,
    [Consignment fee %]                 FLOAT (53)     NULL,
    [Fee value netto]                   NVARCHAR (255) NULL,
    [Sales at retail excl vat excl fee] NVARCHAR (255) NULL,
    [Invoicing model]                   NVARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([Staging_NewStockId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_FR_Staging_NewStock_FileLoadId]
    ON [FR].[Staging_NewStock]([FileLoadId] ASC);

