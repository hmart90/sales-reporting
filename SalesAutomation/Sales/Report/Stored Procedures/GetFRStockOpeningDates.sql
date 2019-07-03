CREATE PROCEDURE [Report].[GetFRStockOpeningDates]
AS


SELECT [EventDate]
FROM [FR].[StockOpening]
GROUP BY [EventDate]
ORDER BY [EventDate] DESC

RETURN 0
