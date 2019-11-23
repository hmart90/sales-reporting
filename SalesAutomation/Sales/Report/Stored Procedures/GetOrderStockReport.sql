CREATE PROCEDURE [Report].[GetOrderStockReport]
	@EventDate Date
	
AS
	SELECT  
	  o.EventDate
		,p.TPN
		,p.EAN
		,p.TitleHU
      ,opc.[Number]
      ,opc.[Min]
      ,opc.[Max]
	  ,st.SumStock
  FROM [TMPL].[Order] as o
  inner join TMPL.[OrderProductCount] as opc on opc.OrderId = o.OrderId
  inner join dbo.Product as p on opc.ProductId = p.ProductId
  LEFT OUTER JOIN (
	SELECT st.ProductId, SUM(st.[Number]) as SumStock
	FRoM MSTR.Stock as st
	WHERE st.EventDate = DATEADD(dd, 8-(DATEPART(dw, @EventDate)), @EventDate)
	GROUP BY st.ProductId
) as st on st.ProductId = p.ProductId 

  where o.IsActive = 1
		and o.EventDate = @EventDate
RETURN 0
