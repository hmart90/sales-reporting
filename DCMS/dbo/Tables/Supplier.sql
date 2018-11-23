CREATE TABLE [dbo].[Supplier] (
    [SupplierId]                         INT            IDENTITY (1, 1) NOT NULL,
    [LocalActivesupplierCode]            NVARCHAR (100) NOT NULL,
    [LocalActivesupplierLongdescription] NVARCHAR (500) NOT NULL,
    PRIMARY KEY CLUSTERED ([SupplierId] ASC)
);

