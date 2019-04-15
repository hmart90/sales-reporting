create view dbo.Stockreport_Store

as

SELECT 
      [Local Store Store code]
	  ,[Local Store Store name]
  

      ,SUM([Stock units (Daily Shops)]) AS StockUnitsTotal
            
FROM [dbo].[StockMSTR]

where	[Local Active supplier Code] = 41421
		and [Type] = 'dvd'
		and [Day] = '2019-03-26'

GROUP BY	 [Local Store Store code]
	  ,[Local Store Store name]
GO

