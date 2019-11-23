CREATE PROCEDURE [Model].[PredictWithModel]
	@ModelName NVARCHAR(100)
AS
DECLARE @lin_model_raw VARBINARY(MAX) = (SELECT TOP 1 [Object] FROM model.Model WHERE [Name] = @ModelName ORDER BY [Version] DESC);
DECLARE @ModelId INT = (SELECT TOP 1 ModelId FROM model.Model WHERE [Name] = @ModelName ORDER BY [Version] DESC);
DECLARE @RowCount INT = 1

WHILE @RowCount > 0
BEGIN
	with notpredicted AS (
	SELECT TOP 100000 
		pr,
		store,
		date,
		stock,
		sales,
		mw.StockId

	FROM Model.ModelView as mw
	LEFT JOIN Model.Prediction as p on p.StockId = mw.StockId AND p.ModelId = @ModelId
	WHERE p.StockId IS NULL
	)

	INSERT INTO Model.Prediction
		(StockId, Prediction, ModelId)
	SELECT
	  a.StockId, 
	  p.sales_Pred,
	  @ModelId
	FROM PREDICT(MODEL = @lin_model_raw, DATA = notpredicted as a)
	WITH ("sales_Pred" float) as p;

	SET @RowCount = (SELECT @@ROWCOUNT);
END

RETURN 0
