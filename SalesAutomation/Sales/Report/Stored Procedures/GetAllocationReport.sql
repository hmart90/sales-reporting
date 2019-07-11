CREATE PROCEDURE Report.[GetAllocationReport]
	@OrderId INT
AS
SELECT [AllocationId]
      ,s.[OrderProductCountId]
	  ,p.TitleHU
	  ,p.TPN
      ,st.[StoreId]
	  ,st.Code
      ,ISNULL(s.[Number],0) as Number
	  ,ISNULL(rangeprice.Price,0) As Price
FROM [TMPL].[Allocation] as s
INNER JOIN TMPL.OrderProductCount as opc on s.[OrderProductCountId] = opc.[OrderProductCountId]
INNER JOIN dbo.Product as p on p.ProductId = opc.ProductId
INNER JOIN dbo.Store as st on st.StoreId = s.StoreId
LEFT OUTER JOIN (
SELECT [ProductId]
		,FIRST_VALUE(Price) OVER (PARTITION BY [ProductId] ORDER BY EventDate DESC) as Price
FROM [NLF].[Range]
) as rangeprice on rangeprice.ProductId = opc.ProductId

WHERE opc.OrderId = @OrderId

RETURN 0
