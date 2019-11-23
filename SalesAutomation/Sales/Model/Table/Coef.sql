CREATE TABLE [Model].[Coef]
(
	[CoefId] INT IDENTITY(1,1) NOT NULL,
	[ModelId] INT NOT NULL,
	[VariableType] NVARCHAR(100) NOT NULL,
	[VariableId] NVARCHAR(100) NULL,
	[Coefficient] FLOAT NULL,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_Model_Coef] PRIMARY KEY ([CoefId])
)
GO

CREATE TRIGGER Model.[TR_Model_Coef_SetValueForUpdatedUTC]
    ON Model.[Coef]
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE Model.[Coef]
		SET UpdatedUTC = GETUTCDATE()
		WHERE [CoefId] IN (select [CoefId] from Inserted)
    END