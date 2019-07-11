CREATE PROCEDURE [NLF].[UpdateSubSupplierFromRange]
AS

UPDATE p
SET p.SubSupplierId = ss.SubSupplierId
FROM [dbo].[Product] as p
LEFT OUTER JOIN (
SELECT [TPN]
      ,[gyártó/forgalmazó]
FROM [NLF].[Staging_Range]
GROUP BY [TPN]
      ,[gyártó/forgalmazó]
) as rangedata on rangedata.TPN = p.TPN
INNER JOIN dbo.SubSupplier as ss on ss.Name = rangedata.[gyártó/forgalmazó]
WHERE SupplierId = 1 AND p.SubSupplierId IS NULL AND p.TitleHU NOT LIKE 'DELTA%'

RETURN 0
