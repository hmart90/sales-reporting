CREATE PROCEDURE [FR].[MigrateFRMovingData]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);
DECLARE @StartDate DATE = (SELECT StartDate FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);
DECLARE @EndDate DATE = (SELECT EndDate FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);

DELETE FROM FR.StockMoving
WHERE EventDate >= @StartDate AND EventDate <= @EndDate

INSERT INTO [FR].[StockMoving]
           ([ProductId]
           ,[StoreId]
           ,[EventDate]
           ,[Number]
           ,[CostUnitPrice]
           ,[ValueCostPrice])
SELECT p.ProductId
      ,st.StoreId
	  ,[date] AS EventDate
      ,[KészletMennyiség]
      ,[BeszEgységár]
      ,[ÉrtékOnktgAron]
FROM [FR].[Staging_StockMoving] as sto
INNER JOIN dbo.Product as p ON p.TPN = sto.TPN
INNER JOIN dbo.Store as st ON st.Code = sto.Site
WHERE [FileLoadId] = @FileLoadId
