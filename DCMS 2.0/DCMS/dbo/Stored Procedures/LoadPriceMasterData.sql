-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE dbo.LoadPriceMasterData
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

TRUNCATE TABLE [dbo].[PriceMaster];

INSERT INTO [dbo].[PriceMaster]
           (
      [Gyűtő EAN]
	  ,[TPN]
	  ,[EAN*]
	  ,[Forgalmazó*]
      ,[Megnevezés magyar (teljes _)*]
      ,[Megnevezés angol (teljes _)]
      ,[Megnevezés gyűjtőkódos]
      ,[áfa kulcs %]
      ,[JAVASOLT FOGYASZTÓI ÁR érvényesség_-tól]
      ,[JAVASOLT FOGYASZTÓI ÁR érvényesség_-ig]
      ,[JAVASOLT FOGYASZTÓI ÁR Fogyasztói ár (bruttó)]
      ,[DCMS beszerzési ár érvényesség_-tól1]
      ,[DCMS beszerzési ár érvényesség_-ig1]
      ,[DCMS beszerzési ár Beszerzési ár (nettó)]
      ,[DCMS beszerzési ár kalkulált DCMS margin]
      ,[TESCO felé közölt átadási ár érvényesség_-tól2]
      ,[TESCO felé közölt átadási ár érvényesség_-ig2]
      ,[TESCO felé közölt átadási ár Átadási ár (nettó)]
      ,[TESCO felé közölt átadási ár kalkulált Tesco _margin] )

SELECT * FROM OPENROWSET(
	'Microsoft.ACE.OLEDB.12.0'
	,'Excel 12.0;Database=C:\Analytics\Masterdata\Prices_master_data_190305.xlsx;HDR=YES'
	,'SELECT * FROM [new$B19:U]')


END
GO

