CREATE PROCEDURE [TMPL].[CalculateStoreShare]
	@Is67 BIT
AS
	
	TRUNCATE TABLE TMPL.Staging_StoreShare;

	INSERT INTO TMPL.Staging_StoreShare
		(StoreId,Share)
	SELECT s.[StoreId]
		,sum([SalesExclVAT])
	FROM MSTR.[Sales] as s
	INNER JOIN dbo.Store as st ON st.StoreId = s.StoreId
	WHERE [EventDate] >= DATEADD(MONTH, -3 , GETUTCDATE())
			AND ((st.Connection_67 = 1 AND @Is67 = 1) OR (st.Connection_110 = 1 AND @Is67 = 0))
	GROUP BY s.[StoreId];

	DECLARE @TotalSales FLOAT = (SELECT sum(Share) FROM TMPL.Staging_StoreShare);

	UPDATE TMPL.Staging_StoreShare
	SET Share = Share / @TotalSales;

RETURN 0
