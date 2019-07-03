CREATE PROCEDURE [Report].[GetOrderList]

AS
SELECT [OrderId]
      ,[EventDate]
FROM [TMPL].[Order]
WHERE [IsActive] = 1
ORDER BY EventDate DESC

RETURN 0
