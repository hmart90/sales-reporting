CREATE PROCEDURE [Report].[GetOrderProductDecisionContextReport]
	@OrderProductCountId INT
AS

SELECT	s.Name,
		s.Code
		,a.[Number]
		,a.Stock
		,a.TargetNumber
		,a.StoreShare
		,opc.[Min]
		,opc.[Max]
		,ISNULL(maxstock.maxstock,0) as maxstock
		,ISNULL(sumsales.sumsales,0) as sumsales
FROM [TMPL].[Allocation] as a
INNER JOIN TMPL.OrderProductCount as opc on opc.OrderProductCountId = a.OrderProductCountId
INNER JOIN dbo.Store as s on s.StoreId = a.StoreId
LEFT OUTER JOIN (
SELECT [ProductId]
      ,[StoreId]
      ,MAX([Number]) as maxstock
FROM [FR].[StockOpening]
GROUP BY [ProductId],[StoreId]
) as maxstock on maxstock.ProductId = opc.ProductId and maxstock.StoreId = a.StoreId
LEFT OUTER JOIN (
SELECT [ProductId]
      ,[StoreId]
      ,SUM([Number]) as sumsales
FROM [FR].[Sales]
GROUP BY [ProductId],[StoreId]
) as sumsales on sumsales.ProductId = opc.ProductId and sumsales.StoreId = a.StoreId

WHERE a.OrderProductCountId = @OrderProductCountId
  
RETURN 0
