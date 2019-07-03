CREATE PROCEDURE [Report].[GetOrderReport]
	@OrderId INT
AS
SELECT [OrderProductCountId]
      ,[OrderId]
      ,s.[ProductId]
	  ,p.TitleHU
      ,[Number]
      ,[Min]
      ,[Max]
      ,s.[InsertedUTC]
      ,s.[UpdatedUTC]
FROM [TMPL].[OrderProductCount] as s
INNER JOIN dbo.Product as p on p.ProductId = s.ProductId
WHERE s.OrderId = @OrderId

RETURN 0
