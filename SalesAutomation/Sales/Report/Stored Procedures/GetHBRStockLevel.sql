CREATE PROCEDURE [Report].[GetHBRStockLevel]

	@EndDate DATE
AS
	  
  SELECT 
      P.[Category],
      sum(st.[Number]) as TotalUnit
     
      
  FROM [FR]. [StockClosing] as st

  inner join [dbo].Product as P on st.[ProductId] = P.ProductId

  where st.[EventDate] = @EndDate
 and st.[Number] >0
group by P.[Category]
RETURN 0
