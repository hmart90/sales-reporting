CREATE TABLE TMPL.[Staging_OrderProductCount]
(
	[Staging_OrderProductCountId] INT IDENTITY(1,1) NOT NULL,
	[FileLoadId] INT NOT NULL,
	TPN BIGINT NOT NULL,
	[Description] NVARCHAR(1000) NULL,
	[Normal price] FLOAT NULL,
	[Cost price (Tesco)] FLOAT NULL,
	[Cost price in GBP] FLOAT NULL,
	[Quantity] INT NOT NULL,
	[Min] INT NOT NULL DEFAULT 1,
	[Max] INT NOT NULL DEFAULT 7,
    CONSTRAINT [FK_TMPL_Staging_OrderProductCount_FileLoad_FileLoadId] FOREIGN KEY ([FileLoadId]) REFERENCES dbo.FileLoad([FileLoadId]), 
    CONSTRAINT [PK_TMPL_Staging_OrderProductCount] PRIMARY KEY ([Staging_OrderProductCountId])
)
GO


CREATE INDEX [IX_TMPL_Staging_OrderProductCount_FileLoadId] ON [TMPL].[Staging_OrderProductCount] (FileLoadId)
