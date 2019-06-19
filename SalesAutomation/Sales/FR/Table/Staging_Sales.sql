CREATE TABLE [dbo].[Staging_Sales]
(
	[Staging_SalesId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[FileLoadId] INT NOT NULL,
	[TPN] BIGINT NOT NULL,	
	[Description] NVARCHAR(500) NOT NULL,
	[Értékesített készlet (db)] INT NOT NULL,
	[Beszerzési Egységár] FLOAT NOT NULL,
	[Értékesített készlet (érték)] FLOAT NOT NULL,
	[Árrés] FLOAT NOT NULL,
	[Nettó Árbevétel] FLOAT NOT NULL,
	[Bruttó Árbevétel] INT NOT NULL,
	[Dátum] DATE NOT NULL,
	[Site] INT NOT NULL
)