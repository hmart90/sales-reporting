CREATE TABLE [dbo].[TempFileDates] (
    [TempFileDatesId] INT  IDENTITY (1, 1) NOT NULL,
    [EventDate]       DATE NOT NULL,
    PRIMARY KEY CLUSTERED ([TempFileDatesId] ASC)
);

