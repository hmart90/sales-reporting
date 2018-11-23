CREATE TABLE [dbo].[Product] (
    [ProductId]                   INT            IDENTITY (1, 1) NOT NULL,
    [Category]                    NVARCHAR (10)  NOT NULL,
    [LocalTPNitemTPN]             NVARCHAR (100) NULL,
    [LocalTPNitemLongdescription] NVARCHAR (500) NOT NULL,
    [LocalTPNitemPrimaryEAN]      NVARCHAR (100) NULL,
    [LocalTPNitemStatus]          NVARCHAR (100) NOT NULL,
    [SupplierId]                  INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([ProductId] ASC)
);

