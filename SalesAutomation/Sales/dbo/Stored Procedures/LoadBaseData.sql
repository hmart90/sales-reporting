CREATE PROCEDURE [dbo].[LoadBaseData]

AS

DELETE FROM dbo.Price
DELETE FROM dbo.Product
DELETE FROM dbo.Supplier
DELETE FROM dbo.Store

INSERT INTO dbo.SubSupplier ([Name],[IsConsignement],[Margin],TescoCode,TescoName) VALUES ('ADS',1,0.3,2100239,'ADS SERVICE KFT.(EDI)');
INSERT INTO dbo.SubSupplier ([Name],[IsConsignement],[Margin],TescoCode,TescoName) VALUES ('Btech',1,0.28,40726,'BTECH MO.KFT.(S)(EDI)_HU40726_BUDAPES');
INSERT INTO dbo.SubSupplier ([Name],[IsConsignement],[Margin],TescoCode,TescoName) VALUES ('BALLARDING',1,0.27,0,'BALLARDING');
INSERT INTO dbo.SubSupplier ([Name],[IsConsignement],[Margin],TescoCode,TescoName) VALUES ('CENEGA',0,0.3036,40148,'CENEGA HUNGARY KFT._HU40148_BUDAPES');
INSERT INTO dbo.SubSupplier ([Name],[IsConsignement],[Margin],TescoCode,TescoName) VALUES ('GHE',1,0.222172864321608,40397,'GAMMA HOME ENTERTAINMENT KFT.');
INSERT INTO dbo.SubSupplier ([Name],[IsConsignement],[Margin],TescoCode,TescoName) VALUES ('MAGNEW',0,0.2791,0,'MAGNEW');
INSERT INTO dbo.SubSupplier ([Name],[IsConsignement],[Margin],TescoCode,TescoName) VALUES ('Neosz',1,0.3,40715,'NEOSZ KFT.');
INSERT INTO dbo.SubSupplier ([Name],[IsConsignement],[Margin],TescoCode,TescoName) VALUES ('Pro Video',1,0.29,40520,'PRO VIDEOFILM&DISTRIBUTIO(EDI)_HU21339_BUDAPES');
INSERT INTO dbo.SubSupplier ([Name],[IsConsignement],[Margin],TescoCode,TescoName) VALUES ('Simactive',1,0.31,40502,'SIMACTIVE DISTRIBUTION KFT');
INSERT INTO dbo.SubSupplier ([Name],[IsConsignement],[Margin],TescoCode,TescoName) VALUES ('DCMS',1,0,41421,'DELTA CATMAN SERVICES KFT._HU41421_BUDAKES');

INSERT INTO dbo.Supplier ([Name],TescoCode,TescoName) VALUES ('DCMS',41421,'DELTA CATMAN SERVICES KFT._HU41421_BUDAKES');

DECLARE @SupplierId INT = (SELECT SupplierId FROM dbo.Supplier WHERE TescoCode = 41421);

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
	  ,SubSupplierId
	  ,Category
      ,TitleHU
      ,TitleEN)
SELECT [TPN*]
		,[EAN]
		,@SupplierId
		,s.SubSupplierId
		,[Kategória]
		,[Megnevezés magyar (teljes _)*]
		,[Megnevezés angol (teljes _)] 
FROM OPENROWSET(
	'Microsoft.ACE.OLEDB.12.0'
	,'Excel 12.0;Database=C:\Development\database\SalesAutomation\BaseData\Product_master_data_190320.xlsx;HDR=YES'
	,'SELECT * FROM [new$B2:H]') as xcl
INNER JOIN dbo.SubSupplier as s ON s.Name = xcl.[Forgalmazó]


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
