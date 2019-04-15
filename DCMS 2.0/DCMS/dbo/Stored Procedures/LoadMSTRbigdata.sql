CREATE PROCEDURE [dbo].[LoadMSTRbigdata]
AS

INSERT INTO [dbo].[StockMSTRWEEKLY]
           (
    [Local TPN item TPN] , 
    [Local TPN item Long description] ,
    [Local TPN item Primary EAN] ,
    [Local TPN item Status] ,
    [Local Active supplier Code],
    [Local Active supplier Long description] ,
    [Local Store Store code] ,
    [Local Store Store name] ,
    [Day] ,
    [Fiscal week] ,
    [Stock units (Daily Shops)] ,
    [Total Stock value Daily (cost price)] )

SELECT * FROM OPENROWSET(
	'Microsoft.ACE.OLEDB.12.0'
	,'Excel 12.0;Database=C:\Analytics\Tesco riportok\Stock_17_18\dvd_stock_2017_period.xlsx;HDR=YES'
	,'SELECT * FROM [DVD-stock-LY-daily$A4:L]')

RETURN 0
GO

