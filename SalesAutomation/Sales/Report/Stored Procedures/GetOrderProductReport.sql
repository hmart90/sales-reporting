CREATE PROCEDURE [Report].[GetOrderProductReport]
	@StartDate date,
	@EndDate date
AS

SELECT  
	  o.EventDate
		,p.TitleHU
		,p.TPN
		,p.EAN
      ,opc.[Number]
      ,opc.[Min]
      ,opc.[Max]
  FROM [TMPL].[Order] as o
  inner join TMPL.[OrderProductCount] as opc on opc.OrderId = o.OrderId
  inner join dbo.Product as p on opc.ProductId = p.ProductId

  where o.IsActive = 1
		and o.EventDate >= @StartDate
		and o.EventDate <= @EndDate

RETURN 0
