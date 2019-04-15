create view dbo.Salesreport_TPN

as

SELECT 
      [Local TPN item TPN]
	  ,[Local TPN item Primary EAN]
      ,[Local TPN item Long description]

      ,SUM([Sold units]) AS SoldUnitsTotal
      ,SUM([Sales excl VAT]) AS SalesexclVATTotal
      
FROM [dbo].[SalesMSTR]

where	[Local Active supplier Code] = 41421
		and [Type] = 'dvd'
		and [Fiscal week] = 'f2018w45'

GROUP BY	[Local TPN item TPN]
			,[Local TPN item Long description]
			,[Local TPN item Primary EAN]
GO

