-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSupplierList] 
AS
BEGIN
SELECT [SupplierId]
      ,[LocalActivesupplierCode]
      ,[LocalActivesupplierLongdescription]
  FROM [DCMS].[dbo].[Supplier]

  ORDER BY [LocalActivesupplierLongdescription], [LocalActivesupplierCode]
END
