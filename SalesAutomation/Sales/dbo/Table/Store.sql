CREATE TABLE [dbo].[Store](
	[StoreId] INT IDENTITY(1,1) NOT NULL,
	[Code] [float] NOT NULL,
	[Name] [nvarchar](255) NULL,
	[TypeShortFormat] [nvarchar](255) NULL,
	[TypeLongFormat] [nvarchar](255) NULL,
	[Connection_67] [bit] NULL,
	[Connection_110] [bit] NULL, 
	[InsertedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
	[UpdatedUTC] DATETIME2(7) NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT [PK_dbo_Store] PRIMARY KEY ([StoreId])
) ON [PRIMARY]
GO

CREATE TRIGGER [dbo].[TR_dbo_Store_SetValueForUpdatedUTC]
    ON [dbo].[Store]
    FOR DELETE, INSERT, UPDATE
    AS
    BEGIN
		UPDATE dbo.[Store]
		SET UpdatedUTC = GETUTCDATE()
		WHERE StoreId IN (select StoreId from Inserted)
    END