CREATE TABLE [FR].[Staging_StockMoving]
(
	[Staging_StockMovingId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[FileLoadId] INT NOT NULL,
	[site] INT NOT NULL,
	[tpn] BIGINT NOT NULL,
	[Product] NVARCHAR(500) NOT NULL,
	[date_e] DATE NOT NULL,
	[corr] NVARCHAR(500) NULL,
	[KészletMennyiség] INT NOT NULL,
	[BeszEgységár] FLOAT NULL,
	[ÉrtékOnktgAron] FLOAT NULL,
	[date] DATE NOT NULL,
	[Comment] NVARCHAR(500) NOT NULL,
)
