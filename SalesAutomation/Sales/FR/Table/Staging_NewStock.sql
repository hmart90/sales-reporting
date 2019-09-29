CREATE TABLE FR.[Staging_NewStock]
(
	[Staging_NewStockId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[FileLoadId] INT NOT NULL,
	[Site] [float] NULL,
	[Site name] [nvarchar](255) NULL,
	[Supplier ID] [float] NULL,
	[TPN] [float] NULL,
	[TPN description] [nvarchar](255) NULL,
	[Last closing stock QTY] [float] NULL,
	[Receivings QTY] [float] NULL,
	[Returns QTY] [float] NULL,
	[Returns at COST] [float] NULL,
	[Stock adjustments QTY] [float] NULL,
	[Stock adjustments at value] [float] NULL,
	[Stock-Take adjustments QTY] [float] NULL,
	[Stock-Take adjustments at value] [float] NULL,
	[Transfers OUT QTY] [float] NULL,
	[Transfers IN QTY] [float] NULL,
	[Sales QTY] [float] NULL,
	[Stock in transit QTY] [float] NULL,
	[Unprocessed movements QTY] [float] NULL,
	[Closing stock QTY] [float] NULL,
	[COGS] [float] NULL,
	[Gross margin] [float] NULL,
	[Sales at retail incl VAT] [nvarchar](255) NULL,
	[VAT] [float] NULL,
	[Sales at retail excl VAT] [nvarchar](255) NULL,
	[Consignment fee %] [float] NULL,
	[Fee value netto] [nvarchar](255) NULL,
	[Sales at retail excl vat excl fee] [nvarchar](255) NULL,
	[Invoicing model] [nvarchar](255) NULL

)

GO

CREATE INDEX [IX_FR_Staging_NewStock_FileLoadId] ON [FR].Staging_NewStock (FileLoadId)

