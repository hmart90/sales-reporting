CREATE PROCEDURE [Report].[GetOrderProductList]
	@OrderId INT
AS

SELECT opc.[OrderProductCountId]
      ,p.TitleHU
FROM [TMPL].[OrderProductCount] as opc
INNER JOIN dbo.Product as p on p.ProductId = opc.ProductId
WHERE opc.[OrderId] = @OrderId

UNION ALL

SELECT NULL, NULL

RETURN 0
