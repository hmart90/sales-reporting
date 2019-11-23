CREATE PROCEDURE [Model].[GetProductScores]
	@ModelName NVARCHAR(100)
AS

SELECT p.TitleHU
      ,[Coefficient]
	  ,ROUND([Coefficient],1) as rounded
	  ,p.SubSupplierId
	  ,sumsales.SumSales
  FROM [Model].[Coef] as coef
  join dbo.Product as p on cast(p.ProductId as nvarchar(100)) = coef.VariableId
  left join (select productId, SUM(Number) as SumSales
  FROM MSTR.Sales
  group by productId) as sumsales on sumsales.ProductId = p.ProductId
  inner join model.Model as m on m.ModelId = coef.ModelId
  where [VariableType] = 'pr' AND m.IsActive = 1 AND m.[Name]= @ModelName

RETURN 0
