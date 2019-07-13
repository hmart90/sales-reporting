CREATE TABLE [FR].[Staging_StockLoading]
(
	[Staging_StockLoadingId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[FileLoadId] INT NOT NULL,
	[tpn] BIGINT NOT NULL,
	[Product] NVARCHAR(500) NULL,
	[date_e] DATE NULL,
	[corr] NVARCHAR(500) NULL,
	[KészletMennyiség] INT NULL,
	[BeszEgységár] FLOAT NULL,
	[ÉrtékOnktgAron] FLOAT NULL,
	[date] DATE NOT NULL,
	[site] INT NOT NULL
)

GO

CREATE INDEX [IX_FR_Staging_StockLoading_FileLoadId] ON [FR].Staging_StockLoading (FileLoadId)

