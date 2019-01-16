CREATE VIEW dbo.StoreShares_by_Sales

AS

SELECT [Local Store Store code]
		,sum(mstr.[Sold units]*pm.[DCMS beszerzési ár Beszerzési ár (nettó)])/max(TotalSalesValue.TotalSales) as  TotalSalesShare
FROM [dbo].[SalesMSTR] as mstr
INNER JOIN dbo.PriceMaster AS pm ON pm.TPN = mstr.[Local TPN item TPN]
LEFT JOIN (
	SELECT sum(mstr.[Sold units]*pm.[DCMS beszerzési ár Beszerzési ár (nettó)]) as  TotalSales
	FROM [dbo].[SalesMSTR] as mstr
	INNER JOIN dbo.PriceMaster AS pm ON pm.TPN = mstr.[Local TPN item TPN]
) as TotalSalesValue ON 1=1

GROUP BY [Local Store Store code]
GO

