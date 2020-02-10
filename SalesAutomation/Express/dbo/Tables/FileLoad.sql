CREATE TABLE [dbo].[FileLoad] (
    [FileLoadId]  INT             IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (500)  NOT NULL,
    [Path]        NVARCHAR (1000) NOT NULL,
    [NewName]     NVARCHAR (1000) NULL,
    [StartDate]   DATE            NULL,
    [EndDate]     DATE            NULL,
    [Type]        NVARCHAR (100)  NULL,
    [IsLoaded]    BIT             DEFAULT ((0)) NOT NULL,
    [InsertedUTC] DATETIME2 (7)   DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]  DATETIME2 (7)   DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_dbo_FileLoad] PRIMARY KEY CLUSTERED ([FileLoadId] ASC)
);


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