CREATE PROCEDURE Report.[GetAllocationReport]
	@OrderId INT
AS
SELECT [AllocationId]
      ,s.[OrderProductCountId]
	  ,p.TitleHU
	  ,p.TPN
      ,s.[StoreId]
	  ,st.Code
      ,s.[Number]
FROM [TMPL].[Allocation] as s
INNER JOIN TMPL.OrderProductCount as opc on s.[OrderProductCountId] = opc.[OrderProductCountId]
INNER JOIN dbo.Product as p on p.ProductId = opc.ProductId
RIGHT JOIN dbo.Store as st on st.StoreId = s.StoreId

WHERE opc.OrderId = @OrderId OR opc.OrderId IS NULL

RETURN 0
