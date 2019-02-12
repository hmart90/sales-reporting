CREATE TABLE [dbo].[FileNamePath]
(
	[FileNamePathId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Filename] nvarchar(500) NOT NULL,
	[Path] nvarchar(500) NOT NULL,
	[FilenamePath] nvarchar(500) NOT NULL,
	[SheetName] nvarchar(500) NULL,
	[Type] nvarchar(50) NOT NULL,
	[SalesOrStock] nvarchar(50) NOT NULL,
	[Processed] BIT not null DEFAULT(0)

)
