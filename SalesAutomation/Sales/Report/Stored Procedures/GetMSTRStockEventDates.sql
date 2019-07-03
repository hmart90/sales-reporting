CREATE PROCEDURE [Report].[GetMSTRStockEventDates]
AS
SELECT [EventDate]
FROM [MSTR].[Stock]
GROUP BY [EventDate]
ORDER BY [EventDate] DESC

RETURN 0
