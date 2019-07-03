CREATE PROCEDURE [Report].[GetUploadedFileList]

AS
SELECT [FileLoadId]
      ,[Name]
      ,[Path]
      ,[NewName]
      ,[StartDate]
      ,[EndDate]
      ,[Type]
      ,[IsLoaded]
      ,[InsertedUTC]
      ,[UpdatedUTC]
FROM [dbo].[FileLoad]

ORDER BY [UpdatedUTC] DESC

RETURN 0
