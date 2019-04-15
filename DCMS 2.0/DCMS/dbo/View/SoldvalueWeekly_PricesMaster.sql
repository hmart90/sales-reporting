create view dbo.SoldvalueWeekly_PricesMaster
as

SELECT 
      [Fiscal week]
	  ,[Local TPN item TPN]
	  ,[Local TPN item Primary EAN]
      ,[Local TPN item Long description]
      ,SUM([Sold units]) AS SoldUnitsTotal
	  ,pm.[JAVASOLT FOGYASZTÓI ÁR Fogyasztói ár (bruttó)]
	  ,pm.[TESCO felé közölt átadási ár Átadási ár (nettó)]
	  ,SUM(pm.[TESCO felé közölt átadási ár Átadási ár (nettó)]*[Sold units]) AS [SoldValue]
	  
      
FROM [dbo].[SalesMSTR] AS mstr

INNER JOIN dbo.PriceMaster AS pm ON mstr.[Local TPN item TPN] = pm.[TPN]

where	[Local Active supplier Code] = 41421
		and [Fiscal week] >= 'f2018w42'
		

GROUP BY	 [Fiscal week]
            ,[Local TPN item TPN]
			,[Local TPN item Long description]
			,[Local TPN item Primary EAN]
			,pm.[JAVASOLT FOGYASZTÓI ÁR Fogyasztói ár (bruttó)]
			,pm.[TESCO felé közölt átadási ár Átadási ár (nettó)]
GO

