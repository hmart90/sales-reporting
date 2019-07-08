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
	  ,alloc.AllocSum
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
LEFT JOIN (
SELECT 
	sc.OrderProductCountId,
	SUM(sc.Number) AS AllocSum
FROM TMPL.Allocation as sc
INNER JOIN TMPL.[OrderProductCount] as opc on opc.OrderProductCountId = sc.OrderProductCountId
WHERE opc.OrderId = @OrderId
GROUP BY sc.OrderProductCountId
) as alloc ON alloc.OrderProductCountId = s.OrderProductCountId
WHERE s.OrderId = @OrderId
RETURN 0
