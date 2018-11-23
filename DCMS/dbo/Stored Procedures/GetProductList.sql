-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProductList]
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

  order by [LocalTPNitemLongdescription] asc
END
