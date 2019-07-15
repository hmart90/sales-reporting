CREATE PROCEDURE [NLF].[UpdateProductFromRange]
AS

UPDATE p
SET p.[EAN] = st.EAN
FROM [dbo].[Product] as p
INNER JOIN NLF.Staging_Range as st on st.TPN = p.TPN
where p.[EAN] IS NULL AND [SubSupplierId] IS NOT NULL

RETURN 0
