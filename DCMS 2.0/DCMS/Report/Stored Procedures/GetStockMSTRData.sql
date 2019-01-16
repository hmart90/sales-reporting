CREATE PROCEDURE [dbo].[GetStockMSTRData]

AS
	SELECT [StockMSTRId]
      ,[Local TPN item TPN]
      ,[Local TPN item Long description]
      ,[Local TPN item Primary EAN]
      ,[Local TPN item Status]
      ,[Sca Pack Qty]
      ,[Local Active supplier Code]
      ,[Local Active supplier Long description]
      ,[Local Store Store code]
      ,[Local Store Store name]
      ,[Day]
      ,[Fiscal week]
      ,[Stock units (Daily Shops)]
      ,[Total Stock value Daily (cost price)]
      ,[Type]
      ,[Filename]
	FROM [dbo].[StockMSTR]

RETURN 0
