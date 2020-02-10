CREATE TABLE [dbo].[TempExcelSheet] (
    [TempExcelSheetId] INT            IDENTITY (1, 1) NOT NULL,
    [SheetName]        NVARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([TempExcelSheetId] ASC)
);

