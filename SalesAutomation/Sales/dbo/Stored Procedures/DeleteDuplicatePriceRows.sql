CREATE PROCEDURE [dbo].[DeleteDuplicatePriceRows]
AS

DELETE FROM [dbo].[Price]
      WHERE PriceId IN (SELECT MinPriceId
FROM 
(SELECT  
   
      [ProductId]
      ,[StartDate]
      ,[EndDate]
    ,count([PriceId]) as CountPriceId
    ,min([PriceId]) as MinPriceId

  FROM [dbo].[Price]
  
  group by [ProductId]
      ,[StartDate]
      ,[EndDate]
having count([PriceId])=2 ) as DuplicateRows)

RETURN 0
