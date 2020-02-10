CREATE TABLE [FR].[Sales] (
    [SalesId]         INT           IDENTITY (1, 1) NOT NULL,
    [Staging_SalesId] INT           NULL,
    [ProductId]       INT           NOT NULL,
    [StoreId]         INT           NOT NULL,
    [EventDate]       DATE          NOT NULL,
    [Number]          INT           NOT NULL,
    [CostPrice]       FLOAT (53)    NOT NULL,
    [ValueCostPrice]  FLOAT (53)    NOT NULL,
    [PriceMargin]     FLOAT (53)    NOT NULL,
    [NetSales]        FLOAT (53)    NOT NULL,
    [BrutSales]       INT           NOT NULL,
    [InsertedUTC]     DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    [UpdatedUTC]      DATETIME2 (7) DEFAULT (getutcdate()) NOT NULL,
    CONSTRAINT [PK_FR_Sales_SalesId] PRIMARY KEY CLUSTERED ([SalesId] ASC),
    CONSTRAINT [FK_FR_Sales_dbo_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId]),
    CONSTRAINT [FK_FR_Sales_dbo_Store] FOREIGN KEY ([StoreId]) REFERENCES [dbo].[Store] ([StoreId]),
);


GO

CREATE TRIGGER FR.[TR_FR_Sales_SetValueForUpdatedUTC]
    ON FR.Sales
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE FR.Sales
		SET UpdatedUTC = GETUTCDATE()
		WHERE SalesId IN (select SalesId from Inserted)
    END