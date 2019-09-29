CREATE PROCEDURE [Report].[GetHBRSalesValue]
	@StartDate DATE,
	@EndDate DATE
AS
	SELECT 
      
      sum(s.Number * pr.TescoRetailPrice/1.27) as SumWeeklyNoVATSalesValue
     
      
  FROM [FR].[Sales] as s

  inner join [dbo].Product as p on s.[ProductId] = p.ProductId
  inner join [dbo].Price as pr on s.[ProductId] = pr.[ProductId]

  where s.[EventDate] >= @StartDate
		and s.[EventDate] <= @EndDate
		and s.[Number] > 0
		and pr.StartDate <= s.[EventDate]
		and (pr.EndDate >= s.[EventDate] OR pr.EndDate IS NULL)

RETURN 0
