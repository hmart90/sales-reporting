CREATE TABLE [Model].[Prediction]
(
	[PredictionId] INT IDENTITY(1,1) NOT NULL,
	[StockId] INT NOT NULL,
	[Prediction] FLOAT NOT NULL,
	[ModelId] INT NOT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_Model_Prediction] PRIMARY KEY ([PredictionId])
)
GO

CREATE TRIGGER Model.[TR_Model_Prediction_SetValueForUpdatedUTC]
    ON Model.[Prediction]
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE Model.[Prediction]
		SET UpdatedUTC = GETUTCDATE()
		WHERE [PredictionId] IN (select [PredictionId] from Inserted)
    END

