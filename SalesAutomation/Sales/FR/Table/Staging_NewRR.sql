CREATE TABLE [FR].[Staging_NewRR]
(
	[Staging_NewRRId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[FileLoadId] INT NOT NULL,
	[Site] [float] NULL,
	[Receiving number] [float] NULL,
	[Supplier] [float] NULL,
	[Original Supplier ID] [float] NULL,
	[Dept] [float] NULL,
	[Status] [nvarchar](255) NULL,
	[Receiving date] [float] NULL,
	[Processed date] [float] NULL,
	[Order number] [float] NULL,
	[DISPATCH] [float] NULL,
	[TPN] [float] NULL,
	[TPN_] [float] NULL,
	[TPN Description] [nvarchar](255) NULL,
	[Div] [float] NULL,
	[Dep] [float] NULL,
	[Sec] [float] NULL,
	[QTY] [float] NULL,
	[Value] [float] NULL,
	[Orig_S] [nvarchar](255) NULL
)

GO

CREATE INDEX [IX_FR_Staging_NewRR_FileLoadId] ON [FR].[Staging_NewRR] (FileLoadId)
