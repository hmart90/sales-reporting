CREATE TABLE [dbo].[ProductMaster] (
    [EAN*]                          BIGINT         NULL,
    [TPN]                           BIGINT         NULL,
    [EAN]                           BIGINT         NULL,
    [Kategória]                     NVARCHAR (255) NULL,
    [Forgalmazó]                    NVARCHAR (255) NULL,
    [Gyűjtő EAN]                    BIGINT         NULL,
    [Megnevezés magyar (teljes !)*] NVARCHAR (255) NULL,
    [Megnevezés angol (teljes !)]   NVARCHAR (255) NULL
);
GO

