CREATE PROCEDURE [Report].[GetOrderProductStoreList]
	@OrderId INT,
	@OrderProductCountId INT
AS

SELECT NULL as StoreId, NULL as [Name]

UNION ALL

SELECT s.StoreId,
		s.Name

FROM [dbo].[Product] as p
INNER JOIN TMPL.OrderProductCount as opc on opc.ProductId = p.ProductId
LEFT OUTER JOIN (
SELECT st.[ProductId]
      ,st.[StoreId]
      ,MIN(st.[EventDate]) as FirstStockDate
FROM [MSTR].[Stock] as st
WHERE st.Number > 0
GROUP BY [ProductId],[StoreId]
) as firststockdate on FirstStockDate.ProductId = p.ProductId
INNER JOIN dbo.Store as s on s.StoreId = firststockdate.StoreId
INNER JOIN TMPL.Allocation as a on opc.OrderProductCountId = a.OrderProductCountId and a.StoreId = firststockdate.StoreId
INNER JOIN MSTR.Stock as st on st.ProductId = p.ProductId and st.StoreId = firststockdate.StoreId AND st.EventDate = firststockdate.FirstStockDate

WHERE opc.OrderId = @OrderId
		AND (opc.OrderProductCountId = @OrderProductCountId OR @OrderProductCountId IS NULL)

GROUP BY s.StoreId,	s.Name

ORDER BY StoreId

RETURN 0
