CREATE TABLE [dbo].[TempDirectoryContent] (
    [TempDirectoryContentId] INT            IDENTITY (1, 1) NOT NULL,
    [Name]                   NVARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([TempDirectoryContentId] ASC)
);

