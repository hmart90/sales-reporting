﻿CREATE PROCEDURE [TMPL].[CalculateNewOrderProductAllocation]
	@OrderProductCountId INT
AS
DECLARE @ProductId INT = (SELECT ProductId FROM TMPL.OrderProductCount WHERE OrderProductCountId = @OrderProductCountId);
DECLARE @TargetCount INT = (SELECT Number FROM TMPL.OrderProductCount WHERE OrderProductCountId = @OrderProductCountId);
DECLARE @Min INT = (SELECT [Min] FROM TMPL.OrderProductCount WHERE OrderProductCountId = @OrderProductCountId);
DECLARE @Max INT = (SELECT [Max] FROM TMPL.OrderProductCount WHERE OrderProductCountId = @OrderProductCountId);
DECLARE @CurrentPseudo INT = @TargetCount;
DECLARE @CurrentCount INT = 0;
DECLARE @Is67 BIT = (SELECT TOP 1 (CASE WHEN Connectioncount = 67 THEN 1 ELSE 0 END) FROM NLF.[Range] WHERE ProductId = @ProductId ORDER BY EventDate DESC);
DECLARE @Cycle INT = 0;
EXEC [TMPL].[CalculateStoreShare] @Is67;

WHILE @CurrentCount <> @TargetCount AND @Cycle < 1000
	BEGIN
		TRUNCATE TABLE TMPL.Staging_Allocation

		INSERT INTO TMPL.Staging_Allocation
			(ProductId,StoreId,Number)

		SELECT 
			@ProductId,
			stss.StoreId,
			(CASE	
				WHEN round(stss.Share * cast(@CurrentPseudo as FLOAT) , 0) > @Max THEN @Max
				WHEN round(stss.Share * cast(@CurrentPseudo as FLOAT) , 0) < @Min THEN @Min
				ELSE round(stss.Share * cast(@CurrentPseudo as FLOAT) , 0)
			END		
			) AS TargetAllocation

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

		INSERT INTO #TempTable (StoreId)

		SELECT TOP (@Difference) StoreId FROM TMPL.Staging_Allocation WHERE Number > @Min AND Number < @Max

		UPDATE t
		SET Number = (CASE WHEN @CurrentCount > @TargetCount THEN Number - 1 ELSE Number + 1 END)
		FROM TMPL.Staging_Allocation as t
		INNER JOIN #TempTable as tt on tt.StoreId = t.StoreId

		DROP TABLE IF EXISTS #TempTable;

	END

INSERT INTO TMPL.Allocation
	(StoreId,Number,OrderProductCountId)
SELECT
	StoreId,
	Number,
	@OrderProductCountId
FROM TMPL.Staging_Allocation

RETURN 0