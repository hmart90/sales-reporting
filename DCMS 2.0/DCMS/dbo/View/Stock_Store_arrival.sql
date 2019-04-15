create view dbo.Stock_Store_arrival
as


  SELECT 
      [Local TPN item TPN]
	  ,[Local TPN item Primary EAN]
      ,[Local TPN item Long description]
	  ,[Day]

      ,SUM([Stock units (Daily Shops)]) AS StockUnitsTotal
     
      
FROM [dbo].[StockMSTR]

where	[Local Active supplier Code] = 41421
		
		and [Stock units (Daily Shops)] is not null

GROUP BY	[Local TPN item TPN]
			,[Local TPN item Long description]
			,[Local TPN item Primary EAN]
			,[Day]
GO

