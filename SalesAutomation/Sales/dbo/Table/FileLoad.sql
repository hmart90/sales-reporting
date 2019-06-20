CREATE TABLE [dbo].[FileLoad]
(
	[FileLoadId] INT IDENTITY(1,1) NOT NULL,
	[Name] NVARCHAR(500) NOT NULL,
	[Path] NVARCHAR(1000) NOT NULL,
	[StartDate] DATE NULL,
	[EndDate] DATE NULL,
	[Type] NVARCHAR(100) NULL,
	[IsLoaded] BIT NOT NULL DEFAULT 0,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(), 
    CONSTRAINT [PK_dbo_FileLoad] PRIMARY KEY ([FileLoadId]),
)
GO

CREATE TRIGGER [dbo].[TR_dbo_FileLoad_SetValueForUpdatedUTC]
    ON [dbo].FileLoad
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE dbo.FileLoad
		SET UpdatedUTC = GETUTCDATE()
		WHERE FileLoadId IN (select FileLoadId from Inserted)
    END
