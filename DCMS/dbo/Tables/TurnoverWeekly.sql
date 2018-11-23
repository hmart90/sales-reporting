CREATE TABLE [dbo].[TurnoverWeekly] (
    [TurnoverWeeklyId]                   INT            IDENTITY (1, 1) NOT NULL,
    [Category]                           NVARCHAR (10)  NOT NULL,
    [LocalTPNitemTPN]                    NVARCHAR (100) NULL,
    [LocalTPNitemLongdescription]        NVARCHAR (500) NOT NULL,
    [LocalTPNitemPrimaryEAN]             NVARCHAR (100) NULL,
    [LocalTPNitemStatus]                 NVARCHAR (100) NOT NULL,
    [LocalActivesupplierCode]            NVARCHAR (100) NOT NULL,
    [LocalActivesupplierLongdescription] NVARCHAR (500) NOT NULL,
    [Fiscalweek]                         NVARCHAR (10)  NOT NULL,
    [Weeklysumofsoldunits]               INT            NOT NULL,
    [WeeklysumofSalesexclVAT]            FLOAT (53)     NOT NULL,
    [WeeklysumofScanmargin]              FLOAT (53)     NOT NULL,
    PRIMARY KEY CLUSTERED ([TurnoverWeeklyId] ASC)
);

