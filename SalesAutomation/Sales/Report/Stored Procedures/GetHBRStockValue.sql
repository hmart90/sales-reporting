CREATE PROCEDURE [Report].[GetHBRStockValue]
	@EndDate DATE
AS
	 SELECT 
      P.[Category]
      ,sum(st.[Number]*pr.TescoCostPrice) as ValueOfStock
      ,ss.[IsConsignement] 
      
  FROM [FR]. [StockClosing] as st

  inner join [dbo].Product as P on st.[ProductId] = P.ProductId
  inner join [dbo].SubSupplier as ss on p.[SubSupplierId] = ss.SubSupplierId
  inner join [dbo].Price as pr on st.[ProductId] = pr.[ProductId]
  where st.[EventDate] = @EndDate
 and st.[Number] >0
 and pr.StartDate <= @EndDate
 and (pr.EndDate >= @EndDate OR pr.EndDate IS NULL)
group by P.[Category], ss.[IsConsignement]
RETURN 0
