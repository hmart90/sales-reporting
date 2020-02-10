CREATE TABLE [TMPL].[Staging_Allocation] (
    [Staging_AllocationId] INT        IDENTITY (1, 1) NOT NULL,
    [ProductId]            INT        NOT NULL,
    [StoreId]              INT        NOT NULL,
    [Number]               INT        NOT NULL,
    [TargetNumber]         FLOAT (53) NULL
);

