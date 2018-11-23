-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSupplierProductList]
	@SupplierId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT [ProductId]
      ,[Category]
      ,[LocalTPNitemTPN]
      ,[LocalTPNitemLongdescription]
      ,[LocalTPNitemPrimaryEAN]
      ,[LocalTPNitemStatus]
      ,[SupplierId]
  FROM [DCMS].[dbo].[Product]

  WHERE [SupplierId] = @SupplierId

  order by [LocalTPNitemLongdescription] asc
END
