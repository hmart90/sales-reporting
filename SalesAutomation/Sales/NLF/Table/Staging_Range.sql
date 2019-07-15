CREATE TABLE [NLF].[Staging_Range]
(
	[Staging_RangeId] INT IDENTITY(1,1) NOT NULL,
	[FileLoadId] INT NOT NULL,
	[gyártó/forgalmazó]	NVARCHAR(500) NULL,
	[brand/stúdió]	NVARCHAR(500) NULL,	
	[EAN]	BIGINT NULL,	
	[TPN] BIGINT NOT NULL,	
	["megnevezés (borítócím/teljes terméknév)"]	NVARCHAR(500) NULL,
	[kategória (DVD/Gaming)]	NVARCHAR(500) NULL,	
	["választék (cat1-5)"]	NVARCHAR(500) NULL,	
	[Store number] INT NOT NULL,	
	["space (normal mod/ END/ FSDU)"]	NVARCHAR(500) NULL,	
	[range hónap]	DATE NULL,	
	[fogyár] FLOAT NULL,
    CONSTRAINT [PK_Staging_Range] PRIMARY KEY ([Staging_RangeId]), 
    CONSTRAINT [FK_Staging_Range_dbo_FileLoad] FOREIGN KEY ([FileLoadId]) REFERENCES dbo.FileLoad([FileLoadId]),
)

GO

CREATE INDEX [IX_NLF_Staging_Range_FileLoadId] ON [NLF].[Staging_Range] ([FileLoadId])
