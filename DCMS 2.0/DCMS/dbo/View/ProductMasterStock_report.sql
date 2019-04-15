create view dbo.ProductMasterStock_report
as

SELECT [EAN*]
      ,[TPN]
      ,[EAN]
      ,[Kategória]
      ,[Forgalmazó]
      ,[Gyűjtő EAN]
      ,[Megnevezés magyar (teljes !)*]
      ,[Megnevezés angol (teljes !)]
	  ,mstr.[Local Store Store code]
	  ,mstr.[Local Store Store name]
	  ,SUM(mstr.[Stock units (Daily Shops)]) AS StockUnitsTotal
  FROM [dbo].[ProductMaster] as pm

LEFT JOIN dbo.StockMSTR AS mstr ON pm.[TPN] = mstr.[Local TPN item TPN] 

where	[Local Active supplier Code] = 41421
		
		and [Day] = '2019-03-24'
		and [Stock units (Daily Shops)] is not NULL
		

GROUP BY	[EAN*]
      ,[TPN]
      ,[EAN]
      ,[Kategória]
      ,[Forgalmazó]
      ,[Gyűjtő EAN]
      ,[Megnevezés magyar (teljes !)*]
      ,[Megnevezés angol (teljes !)]
	  ,mstr.[Local Store Store code]
	  ,mstr.[Local Store Store name]
GO

