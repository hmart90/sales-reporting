CREATE PROCEDURE [Report].[GetHBRStockItem]
	
	@EndDate DATE
AS
	SELECT 
      P.[Category],
      count(distinct st.[ProductId]) as UnitCount
     
      
  FROM [FR]. [StockClosing] as st

  inner join [dbo].Product as P on st.[ProductId] = P.ProductId

  where st.[EventDate] = @EndDate 
 and st.[Number] >0
group by P.[Category]

RETURN 0
