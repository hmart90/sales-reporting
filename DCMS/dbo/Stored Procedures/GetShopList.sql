CREATE PROCEDURE dbo.GetShopList
AS
BEGIN
	
	SELECT [Local Store Store code]
      ,[Local Store Store name]
      ,[Local Store format]
      ,[Local Store format 2]
	FROM [DCMS].[dbo].[Shop]

END
