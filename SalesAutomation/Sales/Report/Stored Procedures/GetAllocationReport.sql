CREATE PROCEDURE Report.[GetAllocationReport]
	@OrderId INT
AS
SELECT [AllocationId]
      ,s.[OrderProductCountId]
	  ,p.TitleHu
	  ,p.TPN
      ,s.[StoreId]
	  ,st.Code
      ,s.[Number]
FROM [TMPL].[Allocation] as s
INNER JOIN TMPL.OrderProductCount as opc on s.[OrderProductCountId] = opc.[OrderProductCountId]
INNER JOIN dbo.Product as p on p.ProductId = opc.ProductId
INNER JOIN dbo.Store as st on st.StoreId = s.StoreId

WHERE opc.OrderId = @OrderId

RETURN 0
