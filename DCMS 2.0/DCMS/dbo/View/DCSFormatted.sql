CREATE VIEW dbo.DCSformatted
AS
SELECT dcs.[Local TPN item TPN] as tpn
      ,dcs.[Fiscal week] as fw
      ,[Sold units] as su
      ,cast((CASE WHEN [Sold units] > 0 THEN [Sales excl VAT]/[Sold units] ELSE 0 END) as float)/tpn_average_price.AveragePrice as price
	  ,fw.FiscalWeekId-tpn_min_max.minfw as fwdiff
FROM [dbo].[DCSriport] as dcs
INNER JOIN dbo.FiscalWeek as fw ON fw.[Fiscal week] = dcs.[Fiscal week]

LEFT OUTER JOIN (SELECT
						[Local TPN item TPN]
						,min(fw.FiscalWeekId) as minfw
						,max(fw.FiscalWeekId) as maxfw

				FROM [dbo].[DCSriport] as dcs
				INNER JOIN dbo.FiscalWeek as fw ON fw.[Fiscal week] = dcs.[Fiscal week]

				GROUP BY [Local TPN item TPN]
				) as tpn_min_max ON tpn_min_max.[Local TPN item TPN]=dcs.[Local TPN item TPN]

LEFT OUTER JOIN (SELECT
						[Local TPN item TPN]
						,cast(sum([Sales excl VAT]) as float)/cast(sum([Sold units]) as float) as AveragePrice

				FROM [dbo].[DCSriport] as dcs
				WHERE [Sold units] > 0
				GROUP BY [Local TPN item TPN]

				) as tpn_average_price ON tpn_average_price.[Local TPN item TPN]=dcs.[Local TPN item TPN]

WHERE fw.FiscalWeekId >= tpn_min_max.minfw
AND fw.FiscalWeekId <= tpn_min_max.maxfw
AND cast((CASE WHEN [Sold units] > 0 THEN [Sales excl VAT]/[Sold units] ELSE 0 END) as float)/tpn_average_price.AveragePrice is NOT NULL
AND [Sold units]>0
GO

