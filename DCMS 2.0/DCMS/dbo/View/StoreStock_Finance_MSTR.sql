create view dbo.StoreStock_Finance_MSTR
as

SELECT [Site] 
	  ,sum( cast( [Készletmennyiség] as int) ) as PénzügyKészlet
	  ,SUM(mstr.[Stock units (Daily Shops)]) AS StockUnitsTotal
  FROM [dbo].[FinanceMaster] as pm

INNER JOIN dbo.StockMSTR AS mstr ON pm.[Site] = mstr.[Local Store Store code] 

where	mstr.[Local Active supplier Code] = 41421
		
	and mstr.[Day] = '2019-03-10'
	and pm.[Dátum] = '2019-03-10'
		

GROUP BY	[Site]
GO

