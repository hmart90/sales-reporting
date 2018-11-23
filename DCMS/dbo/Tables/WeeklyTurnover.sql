CREATE TABLE [dbo].[WeeklyTurnover] (
    [TurnoverWeeklyId]        INT           IDENTITY (1, 1) NOT NULL,
    [ProductId]               INT           NOT NULL,
    [SupplierId]              INT           NOT NULL,
    [Fiscalweek]              NVARCHAR (10) NOT NULL,
    [Weeklysumofsoldunits]    INT           NOT NULL,
    [WeeklysumofSalesexclVAT] FLOAT (53)    NOT NULL,
    [WeeklysumofScanmargin]   FLOAT (53)    NOT NULL,
    PRIMARY KEY CLUSTERED ([TurnoverWeeklyId] ASC)
);

