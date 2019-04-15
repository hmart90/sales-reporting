CREATE VIEW dbo.YTR_report_supplier
AS

SELECT Supplier
		,sum([SoldUnitsTotal]) AS [SoldUnitsTotal]
      ,round(sum([SalesexclVATTotal]),2) AS [SalesexclVATTotal]
      ,round(sum([NetSalesYTD]),2) AS [NetSalesYTD]
      ,round(sum([NetSalesMTD]),2) AS [NetSalesMTD]

FROM dbo.YTR_report

GROUP BY Supplier
GO

