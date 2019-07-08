CREATE PROCEDURE [NLF].[AutoCreateNewItems]
	@Path as NVARCHAR(1000)
AS
DECLARE @FileLoadId INT = (SELECT FileLoadId FROM dbo.FileLoad WHERE Path = @Path AND IsLoaded = 0);
DECLARE @SupplierId INT = (SELECT SupplierId FROM dbo.Supplier WHERE TescoCode = 41421);

INSERT INTO dbo.SubSupplier
	(Name, IsAutoCreated)

SELECT 
	[gyártó/forgalmazó],1
FROM [NLF].[Staging_Range] as st
LEFT JOIN dbo.SubSupplier as s on s.Name = st.[gyártó/forgalmazó]

where s.SubSupplierId IS NULL AND [gyártó/forgalmazó] != 'Delta' AND st.FileLoadId = @FileLoadId
GROUP BY [gyártó/forgalmazó]

INSERT INTO [dbo].[Product]
           ([SupplierId]
           ,[SubSupplierId]
           ,[TPN]
           ,[EAN]
           ,[TitleHU]
           ,[Category]
           ,[StoreConnection]
           ,[Space]
           ,[IsAutoCreated])

SELECT @SupplierId
		,ss.SubSupplierId
      ,st.[TPN]
      ,st.[EAN]
	  ,["megnevezés (borítócím/teljes terméknév)"]
      ,(CASE WHEN [kategória (DVD/Gaming)] = 'Gaming' THEN 'Gaming' ELSE 'Film' END)
      ,[Store number]
      ,["space (normal mod/ END/ FSDU)"]
	  ,1

FROM [NLF].[Staging_Range] as st
LEFT JOIN dbo.Product as p ON p.TPN = st.TPN
LEFT JOIN dbo.SubSupplier as ss ON ss.Name = st.[gyártó/forgalmazó]

WHERE p.ProductId IS NULL AND st.FileLoadId = @FileLoadId

GROUP BY 
		ss.SubSupplierId
      ,st.[TPN]
      ,st.[EAN]
	  ,["megnevezés (borítócím/teljes terméknév)"]
      ,(CASE WHEN [kategória (DVD/Gaming)] = 'Gaming' THEN 'Gaming' ELSE 'Film' END)
      ,[Store number]
      ,["space (normal mod/ END/ FSDU)"]
