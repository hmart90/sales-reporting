CREATE VIEW dbo.YTR_report
AS

  SELECT 
		pm.[Forgalmazó*] AS Supplier
      ,mstr.[Local TPN item TPN]
	  ,[Local TPN item Primary EAN]
      ,[Local TPN item Long description]
      ,SUM([Sold units]) AS SoldUnitsTotal
      ,SUM([Sales excl VAT]) AS SalesexclVATTotal
	  ,pm.[JAVASOLT FOGYASZTÓI ÁR Fogyasztói ár (bruttó)]
	  ,pm.[DCMS beszerzési ár Beszerzési ár (nettó)]
	  ,SUM(pm.[DCMS beszerzési ár Beszerzési ár (nettó)]*[Sold units]) AS NetSalesYTD
      ,pm.[DCMS beszerzési ár Beszerzési ár (nettó)]*mtd.SoldUnitsTotal AS NetSalesMTD

FROM [dbo].[SalesMSTR] AS mstr

INNER JOIN dbo.PriceMaster AS pm ON mstr.[Local TPN item TPN] = pm.[TPN]

LEFT JOIN (
			SELECT [Local TPN item TPN]
					,SUM([Sold units]) AS SoldUnitsTotal
			FROM dbo.SalesMSTR as mstr

			WHERE	[Day] >= DATEADD(month, DATEDIFF(month, 0, GETDATE()), 0) 

			GROUP BY [Local TPN item TPN]
			) as mtd ON mtd.[Local TPN item TPN] = mstr.[Local TPN item TPN]

where	[Local Active supplier Code] = 41421
		and [Day] >= '2019-01-01'
		and [Day] < DATEADD(month, DATEDIFF(month, 0, GETDATE()), 0) 

GROUP BY	pm.[Forgalmazó*]
			,mstr.[Local TPN item TPN]
			,[Local TPN item Long description]
			,[Local TPN item Primary EAN]
			,pm.[JAVASOLT FOGYASZTÓI ÁR Fogyasztói ár (bruttó)]
			,pm.[DCMS beszerzési ár Beszerzési ár (nettó)]
			,pm.[DCMS beszerzési ár Beszerzési ár (nettó)]*mtd.SoldUnitsTotal

--ORDER BY	[Local TPN item TPN]
--			,[Local TPN item Long description]
--			,[Local TPN item Primary EAN]
GO

