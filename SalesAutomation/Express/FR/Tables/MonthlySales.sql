CREATE TABLE [FR].[MonthlySales] (
    [MonthlySalesId]         INT           IDENTITY (1, 1) NOT NULL,
    [Staging_MonthlySalesId] INT           NOT NULL,
    [ProductId]              INT           NOT NULL,
    [StoreId]                INT           NOT NULL,
    [EventDate]              DATE          NOT NULL,
    [Number]                 INT           NOT NULL,
    [CostPrice]              FLOAT (53)    NOT NULL,
    [ValueCostPrice]         FLOAT (53)    NOT NULL,
    [PriceMargin]            FLOAT (53)    NOT NULL,
    [NetSales]               FLOAT (53)    NOT NULL,
    [BrutSales]              INT           NOT NULL,
    [InsertedUTC]            DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]             DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_FR_MonthlySales_MonthlySalesId] PRIMARY KEY CLUSTERED ([MonthlySalesId] ASC),
    CONSTRAINT [FK_FR_MonthlySales_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId]),
    CONSTRAINT [FK_FR_MonthlySales_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES [dbo].[Store] ([StoreId]),
);


GO

CREATE TRIGGER FR.[TR_FR_MonthlySales_SetValueForUpdatedUTC]
    ON FR.MonthlySales
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE FR.MonthlySales
		SET UpdatedUTC = GETUTCDATE()
		WHERE MonthlySalesId IN (select MonthlySalesId from Inserted)
    END