CREATE PROCEDURE [dbo].[LoadBaseData]

AS

DELETE FROM dbo.Price
DELETE FROM dbo.Product
DELETE FROM dbo.Supplier
DELETE FROM dbo.Store

INSERT INTO dbo.Supplier ([Name],[IsConsignement],[Margin]) VALUES ('ADS',1,0.3)
INSERT INTO dbo.Supplier ([Name],[IsConsignement],[Margin]) VALUES ('Btech',1,0.28)
INSERT INTO dbo.Supplier ([Name],[IsConsignement],[Margin]) VALUES ('BALLARDING',1,0.27)
INSERT INTO dbo.Supplier ([Name],[IsConsignement],[Margin]) VALUES ('CENEGA',0,0.3036)
INSERT INTO dbo.Supplier ([Name],[IsConsignement],[Margin]) VALUES ('GHE',1,0.222172864321608)
INSERT INTO dbo.Supplier ([Name],[IsConsignement],[Margin]) VALUES ('MAGNEW',0,0.2791)
INSERT INTO dbo.Supplier ([Name],[IsConsignement],[Margin]) VALUES ('Neosz',1,0.3)
INSERT INTO dbo.Supplier ([Name],[IsConsignement],[Margin]) VALUES ('Pro Video',1,0.29)
INSERT INTO dbo.Supplier ([Name],[IsConsignement],[Margin]) VALUES ('Simactive',1,0.31)

INSERT INTO [dbo].Store
           (
	  [Code],
	[Name],
	[TypeShortFormat],
	[TypeLongFormat],
	[Connection_67],
	[Connection_110]
	)
SELECT 
		[Local Store Store code],
		[Local Store Store name],
		[Local Store format],
		[Local Store format 2],
		[Connection_68],
		[Connection_112]
FROM OPENROWSET(
	'Microsoft.ACE.OLEDB.12.0'
	,'Excel 12.0;Database=C:\Development\database\SalesAutomation\BaseData\StoreData.xlsx;HDR=YES'
	,'SELECT * FROM [Sheet1$A1:F]') as xcl

INSERT INTO [dbo].Product
           (
	  [TPN]
	  ,[EAN]
	  ,SupplierId
	  ,Category
      ,TitleHU
      ,TitleEN)
SELECT [TPN*]
		,[EAN]
		,s.SupplierId
		,[Kategória]
		,[Megnevezés magyar (teljes _)*]
		,[Megnevezés angol (teljes _)] 
FROM OPENROWSET(
	'Microsoft.ACE.OLEDB.12.0'
	,'Excel 12.0;Database=C:\Development\database\SalesAutomation\BaseData\Product_master_data_190320.xlsx;HDR=YES'
	,'SELECT * FROM [new$B2:H]') as xcl
INNER JOIN dbo.Supplier as s ON s.Name = xcl.[Forgalmazó]


INSERT INTO [dbo].[Price]
           (
     [ProductId],
	[StartDate],
	[EndDate],
	[SupplierRetailPrice],
	[SupplierCostPrice],
	[TescoRetailPrice],
	[TescoCostPrice])

SELECT p.ProductId
		,[JAVASOLT FOGYASZTÓI ÁR érvényesség_-tól]
		,(CASE WHEN [JAVASOLT FOGYASZTÓI ÁR érvényesség_-ig] = 'unlimited' THEN NULL ELSE [JAVASOLT FOGYASZTÓI ÁR érvényesség_-ig] END)
		,[JAVASOLT FOGYASZTÓI ÁR Fogyasztói ár (bruttó)]
		,[DCMS beszerzési ár Beszerzési ár (nettó)]
		,[JAVASOLT FOGYASZTÓI ÁR Fogyasztói ár (bruttó)1]
		,[TESCO felé közölt átadási ár Átadási ár (nettó)]
FROM OPENROWSET(
	'Microsoft.ACE.OLEDB.12.0'
	,'Excel 12.0;Database=C:\Development\database\SalesAutomation\BaseData\Prices_master_data_190620.xlsx;HDR=YES'
	,'SELECT * FROM [new$B19:U]') as xcl
INNER JOIN dbo.Product as p ON p.[TPN] = xcl.[TPN]



RETURN 0
