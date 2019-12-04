CREATE VIEW [Model].ModelView
AS
SELECT TOP 1000000 cast(st.[ProductId] as nvarchar(10)) as pr
      ,cast(st.[StoreId] as nvarchar(10)) as store
      ,cast(st.[EventDate] as nvarchar(10)) as [date]
      ,(CASE WHEN ISNULL(sa.[Number],0)<=0 THEN 0 ELSE 1 END) as sales
      ,(CASE WHEN st.[Number] > 20 THEN '21' ELSE cast(st.[Number] as nvarchar(10)) END) as stock
	  ,st.StockId

FROM [MSTR].Stock as st
LEFT JOIN MSTR.[Sales] as sa on st.ProductId = sa.ProductId AND st.[EventDate] = DATEADD(day,-1,sa.[EventDate]) AND st.[StoreId] = sa.[StoreId]
INNER JOIN dbo.Product as p on p.ProductId = st.ProductId
WHERE st.Number >= 0
	AND st.EventDate >= '2019-01-01'
	AND p.SubSupplierId IS NOT NULL
ORDER BY NEWID()

