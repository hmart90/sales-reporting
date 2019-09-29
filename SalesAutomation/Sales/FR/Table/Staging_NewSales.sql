CREATE TABLE FR.[Staging_NewSales]
(
	[Staging_NewSalesId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[FileLoadId] INT NOT NULL,
	[Site] [float] NULL,
	[TPN] [float] NULL,
	[Supplier ID] [float] NULL,
	[Div] [float] NULL,
	[Dep] [float] NULL,
	[Sec] [float] NULL,
	[Day] [datetime] NULL,
	[Sales QTY] [float] NULL,
	[Sales at retail price excl VAT] [float] NULL,
	[Gross margin] [float] NULL,
	[Sales at cost price] [float] NULL,
	[VAT rate] [float] NULL
)

GO

CREATE INDEX [IX_FR_Staging_NewSales_FileLoadId] ON [FR].[Staging_NewSales] (FileLoadId)
