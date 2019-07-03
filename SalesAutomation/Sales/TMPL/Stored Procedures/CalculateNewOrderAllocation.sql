CREATE PROCEDURE [TMPL].[CalculateNewOrderAllocation]
	@OrderId INT
AS
DROP TABLE IF EXISTS #OrderTempTable;

CREATE TABLE #OrderTempTable (OrderProductCountId INT, RowId INT IDENTITY(1,1))

INSERT INTO #OrderTempTable (OrderProductCountId)
SELECT OrderProductCountId FROM OrderProductCount WHERE OrderId = @OrderId

DECLARE @RowCount INT = (SELECT count(OrderProductCountId) FROM #OrderTempTable);
DECLARE @Cycle INT = 1;
DECLARE @OrderProductCountId INT;
WHILE @Cycle <= @RowCount
	BEGIN

		SET @OrderProductCountId = (SELECT OrderProductCountId FROM #OrderTempTable WHERE RowId = @Cycle);
		EXEC [TMPL].[CalculateNewOrderProductAllocation] @OrderProductCountId;

		SET @Cycle = @Cycle + 1;

	END

DROP TABLE IF EXISTS #OrderTempTable;

RETURN 0
