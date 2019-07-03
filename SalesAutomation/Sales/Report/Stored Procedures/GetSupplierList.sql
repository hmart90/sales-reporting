CREATE PROCEDURE [Report].[GetSupplierList]
	@IsAutoCreated BIT
AS
SELECT [SupplierId]
      ,[Name]
      ,[IsConsignement]
      ,[Margin]
      ,[TescoCode]
      ,[TescoName]
      ,[IsAutoCreated]
      ,[InsertedUTC]
      ,[UpdatedUTC]
  FROM [dbo].[Supplier]

WHERE [IsAutoCreated] = @IsAutoCreated OR @IsAutoCreated IS NULL
  
RETURN 0
