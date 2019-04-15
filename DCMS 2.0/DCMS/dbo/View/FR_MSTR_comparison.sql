CREATE VIEW [dbo].[FR_MSTR_comparison]
	AS

SELECT st.[Local Store Store code]
      ,[Local Store Store name]
	  ,fm.PénzügyKészlet
	  ,mstr.StockUnitsTotal
  FROM [dbo].[Store] as st

INNER JOIN (
SELECT [Site] 
	  ,sum( cast( [Készletmennyiség] as int) ) as PénzügyKészlet
FROM [dbo].[FinanceMaster] as pm
where	pm.[Dátum] = '2019-04-07'
GROUP BY	[Site] 
) as fm ON fm.[Site] = st.[Local Store Store code]


INNER JOIN (
SELECT [Local Store Store code] 
	  ,SUM(mstr.[Stock units (Daily Shops)]) AS StockUnitsTotal
FROM [dbo].StockMSTR as mstr
where	mstr.[Local Active supplier Code] = 41421
	and mstr.[Day] = '2019-04-07'
GROUP BY	[Local Store Store code] 
) as mstr on mstr.[Local Store Store code] = st.[Local Store Store code]
