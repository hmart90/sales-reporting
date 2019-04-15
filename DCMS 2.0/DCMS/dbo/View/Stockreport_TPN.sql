create view dbo.Stockreport_TPN

as

SELECT 
      [Local TPN item TPN]
	  ,[Local TPN item Primary EAN]
      ,[Local TPN item Long description]

      ,SUM([Stock units (Daily Shops)]) AS StockUnitsTotal
            
FROM [dbo].[StockMSTR]

where	[Local Active supplier Code] = 41421
		and [Type] = 'dvd'
		and [Day] = '2019-03-26'

GROUP BY	[Local TPN item TPN]
			,[Local TPN item Long description]
			,[Local TPN item Primary EAN]
GO

