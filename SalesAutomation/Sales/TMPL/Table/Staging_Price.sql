CREATE TABLE [TMPL].[Staging_Price]
(
	[Staging_PriceId] INT IDENTITY(1,1) NOT NULL,
	[FileLoadId] INT NOT NULL,
	[TPN] BIGINT NOT NULL,
	[Megnevezés] NVARCHAR(1000) NULL,
	[Forgalmazó] NVARCHAR(1000) NULL,
	[Új fogyasztói ár] INT NULL,
	[Új beszerzési ár] INT NULL,
	[TESCO Új fogyasztói ár] INT NULL,
	[TESCO Új beszerzési ár] INT NULL,
	[Érvényességi dátum kezdete] DATE NULL,
    CONSTRAINT [PK_TMPL_Staging_Price] PRIMARY KEY ([Staging_PriceId]),
    CONSTRAINT [FK_TMPL_Staging_Price_dbo_FileLoad_FileLoadId] FOREIGN KEY ([FileLoadId]) REFERENCES dbo.FileLoad([FileLoadId])
)

GO

CREATE INDEX [IX_TMPL_Staging_Price_FileLoadId] ON [TMPL].[Staging_Price] ([FileLoadId])
