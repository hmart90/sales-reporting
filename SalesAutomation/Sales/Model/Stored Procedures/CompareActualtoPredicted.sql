CREATE PROCEDURE [Model].[CompareActualtoPredicted]
	@ModelName as NVARCHAR(100)
AS
DECLARE @ModelId INT = (SELECT TOP 1 ModelId FROM model.Model WHERE [Name] = @ModelName ORDER BY [Version] DESC);

SELECT
      st.EventDate
	  ,sum(sa.Number) as Sales
      ,sum([Prediction]) as Prediction
FROM [Model].[Prediction] as p
join MSTR.Stock as st on p.StockId = st.StockId
LEFT JOIN MSTR.[Sales] as sa on st.ProductId = sa.ProductId AND st.[EventDate] = DATEADD(day,-1,sa.[EventDate]) AND st.[StoreId] = sa.[StoreId] 
WHeRE p.ModelId = @ModelId
group by st.EventDate

RETURN 0
