CREATE PROCEDURE [Report].[GetHBRNrSKU]
	@StartDate DATE,
	@EndDate DATE
AS
	SELECT 
      P.[Category],
      count(distinct s.[ProductId]) as UnitCount
     
      
  FROM [FR].[Sales] as S

  inner join [dbo].Product as P on S.[ProductId] = P.ProductId

  where s.[EventDate] >= @StartDate
 and s.[EventDate] <= @EndDate
 and s.[Number] >0
group by P.[Category]


RETURN 0
