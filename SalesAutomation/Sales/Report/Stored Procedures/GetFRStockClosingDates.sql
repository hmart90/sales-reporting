CREATE PROCEDURE [Report].[GetFRStockClosingDates]

AS

SELECT [EventDate]
FROM [FR].[StockClosing]
GROUP BY [EventDate]
ORDER BY [EventDate] DESC

RETURN 0
