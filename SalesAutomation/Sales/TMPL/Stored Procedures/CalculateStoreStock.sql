CREATE PROCEDURE [TMPL].[CalculateStoreStock]
	@ProductId INT
AS
	
	UPDATE TMPL.Staging_StoreShare
	SET Stock = 0;

	DECLARE @LastStockDate DATE = (SELECT MAX(EndDate) FROM dbo.FileLoad WHERE [Type] = 'FinanceReport' AND IsLoaded = 1);

	with laststock as (
		SELECT [StoreId]
			,[Number]
		FROM [FR].[StockClosing]
		WHERE [EventDate] = @LastStockDate
			AND [ProductId] = @ProductId
		)

	UPDATE t
	SET Stock = ISNULL(laststock.Number, 0)
	FROM TMPL.Staging_StoreShare as t
	LEFT JOIN laststock ON laststock.StoreId = t.StoreId

RETURN 0