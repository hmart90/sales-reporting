CREATE PROCEDURE [Report].[GetAllocationStockCheckReport]
	@OrderId INT,
	@OrderProductCountId INT,
	@StoreId INT
AS

SELECT p.TitleHU,
		p.TPN,
		s.Name,
		s.Code,
		firststockdate.FirstStockDate,
		st.Number AS FirstStockNumber,
		a.Number AS AllocatedNumber

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
		AND (s.StoreId = @StoreId OR @StoreId IS NULL)


RETURN 0
