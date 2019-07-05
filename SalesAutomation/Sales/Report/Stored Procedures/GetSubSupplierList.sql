CREATE PROCEDURE [Report].[GetSubSupplierList]
	@IsAutoCreated BIT
AS

SELECT [SubSupplierId]
      ,[Name]
      ,[TescoCode]
      ,[TescoName]
	  ,IsConsignement
	  ,Margin
      ,[IsAutoCreated]
      ,[InsertedUTC]
      ,[UpdatedUTC]
  FROM [dbo].[SubSupplier]

WHERE [IsAutoCreated] = @IsAutoCreated OR @IsAutoCreated IS NULL

RETURN 0
