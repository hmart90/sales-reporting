CREATE TABLE [Model].[Model]
(
	[ModelId] INT IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(100) not null,
    [Version] nvarchar(100) not null,
    [Object] varbinary(max) not null,
	[IsActive] BIT NOT NULL DEFAULT 1,
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_Model_Model] PRIMARY KEY ([ModelId])
)
GO

CREATE TRIGGER Model.[TR_Model_Model_SetValueForUpdatedUTC]
    ON Model.Model
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE Model.Model
		SET UpdatedUTC = GETUTCDATE()
		WHERE [ModelId] IN (select [ModelId] from Inserted)
    END