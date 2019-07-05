CREATE PROCEDURE [Report].[GetOrderCheckReport]
	@OrderId INT
AS

DECLARE @LastStockDate DATE = (SELECT MAX(EndDate) FROM dbo.FileLoad WHERE [Type] = 'FinanceReport' AND IsLoaded = 1);

SELECT s.[ProductId]
	  ,p.TitleHU
	  ,p.TPN
      ,[Number]
      ,[Min]
      ,[Max]
	  ,stock.StockMax
	  ,stock.StockSum
	  ,stock.StoreCount
FROM [TMPL].[OrderProductCount] as s
INNER JOIN dbo.Product as p on p.ProductId = s.ProductId
LEFT JOIN (
SELECT 
	sc.ProductId,
	MAX(sc.Number) AS StockMax,
	SUM(sc.Number) AS StockSum,
	COUNT(distinct sc.StoreId) AS StoreCount
FROM FR.StockClosing as sc
WHERE EventDate = @LastStockDate
GROUP BY ProductId
) as stock ON stock.ProductId = s.ProductId
WHERE s.OrderId = @OrderId
RETURN 0
