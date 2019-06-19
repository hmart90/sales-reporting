CREATE TABLE [dbo].[FileLoad]
(
	[FileLoadId] INT NOT NULL PRIMARY KEY,
	[Name] NVARCHAR(500) NOT NULL,
	[StartDate] DATE NULL,
	[EndDate] DATE NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
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
