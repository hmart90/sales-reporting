CREATE PROCEDURE [TMPL].[CalculateNewOrderProductAllocation]
	@OrderProductCountId INT
AS
DECLARE @ProductId INT = (SELECT ProductId FROM TMPL.OrderProductCount WHERE OrderProductCountId = @OrderProductCountId);
DECLARE @Is67 BIT = (SELECT TOP 1 (CASE WHEN Connectioncount = 67 THEN 1 ELSE 0 END) FROM NLF.[Range] WHERE ProductId = @ProductId ORDER BY EventDate DESC);
EXEC [TMPL].[CalculateStoreShare] @Is67;
EXEC [TMPL].[CalculateStoreStock] @ProductId;
DECLARE @ExistingCount INT = (SELECT SUM(Stock) FROM TMPL.Staging_StoreShare);
DECLARE @TargetCount INT = (SELECT Number FROM TMPL.OrderProductCount WHERE OrderProductCountId = @OrderProductCountId);
SET @TargetCount = @TargetCount + @ExistingCount;
DECLARE @Min INT = (SELECT [Min] FROM TMPL.OrderProductCount WHERE OrderProductCountId = @OrderProductCountId);
DECLARE @Max INT = (SELECT [Max] FROM TMPL.OrderProductCount WHERE OrderProductCountId = @OrderProductCountId);
DECLARE @CurrentPseudo INT = @TargetCount;
DECLARE @CurrentCount INT = 0;
DECLARE @Cycle INT = 0;

WHILE @CurrentCount <> @TargetCount AND @Cycle < 10000
	BEGIN
		TRUNCATE TABLE TMPL.Staging_Allocation

		INSERT INTO TMPL.Staging_Allocation
			(ProductId,StoreId,Number,[TargetNumber])

		SELECT 
			@ProductId,
			stss.StoreId,
			(CASE	
				WHEN round(stss.Share * cast(@CurrentPseudo as FLOAT) , 0) > @Max AND @Max > Stock THEN @Max
				WHEN round(stss.Share * cast(@CurrentPseudo as FLOAT) , 0) > @Max AND @Max <= Stock THEN Stock
				WHEN round(stss.Share * cast(@CurrentPseudo as FLOAT) , 0) < Stock THEN Stock
				WHEN round(stss.Share * cast(@CurrentPseudo as FLOAT) , 0) < @Min THEN @Min
				ELSE round(stss.Share * cast(@CurrentPseudo as FLOAT) , 0)
			END		
			) AS TargetAllocation,
			round(stss.Share * cast(@CurrentPseudo as FLOAT) , 0)

		FROM TMPL.Staging_StoreShare as stss

		SET @CurrentCount = (SELECT sum(Number) FROM TMPL.Staging_Allocation);

		IF @CurrentCount < @TargetCount
			BEGIN
				SET @CurrentPseudo = @CurrentPseudo + 1
			END
		ELSE
			BEGIN
				SET @CurrentPseudo = @CurrentPseudo - 1
			END

		SET @Cycle = @Cycle + 1

	END

IF @CurrentCount <> @TargetCount
	BEGIN
		DECLARE @Difference INT = ABS(@CurrentCount - @TargetCount);
		DROP TABLE IF EXISTS #TempTable;

		CREATE TABLE #TempTable (StoreId INT)

		INSERT INTO #TempTable 
			(StoreId)
		SELECT TOP (@Difference) sta.StoreId 
		FROM TMPL.Staging_Allocation as sta
		INNER JOIN TMPL.Staging_StoreShare as stss ON stss.StoreId = sta.StoreId
		WHERE Number > @Min AND Number < @Max AND Number > stss.Stock

		UPDATE t
		SET Number = (CASE WHEN @CurrentCount > @TargetCount THEN Number - 1 ELSE Number + 1 END)
		FROM TMPL.Staging_Allocation as t
		INNER JOIN #TempTable as tt on tt.StoreId = t.StoreId

		DROP TABLE IF EXISTS #TempTable;

	END

INSERT INTO TMPL.Allocation
	(StoreId,Number,OrderProductCountId,[Stock],[TargetNumber],[StoreShare])
SELECT
	sta.StoreId,
	Number - stss.Stock,
	@OrderProductCountId,
	stss.Stock,
	sta.TargetNumber,
	stss.Share
FROM TMPL.Staging_Allocation as sta
INNER JOIN TMPL.Staging_StoreShare as stss ON stss.StoreId = sta.StoreId

INSERT INTO TMPL.Allocation
	(StoreId,Number,OrderProductCountId,[Stock],[TargetNumber],[StoreShare])
SELECT
	s.StoreId,
	0,
	@OrderProductCountId,
	0,
	0,
	0
FROM dbo.Store as s
WHERE s.StoreId NOT IN (SELECT StoreId FROM TMPL.Staging_Allocation)


RETURN 0
