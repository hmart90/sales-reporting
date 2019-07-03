CREATE PROCEDURE [Report].[GetStoreList]

AS
SELECT [StoreId]
      ,[Code]
      ,[Name]
      ,[TypeShortFormat]
      ,[TypeLongFormat]
      ,[Connection_67]
      ,[Connection_110]
      ,[InsertedUTC]
      ,[UpdatedUTC]
 FROM [dbo].[Store]
  
  
 RETURN 0
