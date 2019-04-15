CREATE TABLE [dbo].[PriceMaster] (
    [PriceMastId]                                          INT            IDENTITY (1, 1) NOT NULL,
    [Gyűtő EAN]                                            NVARCHAR (255) NULL,
    [TPN]                                                  BIGINT         NULL,
    [EAN*]                                                 BIGINT         NULL,
    [Forgalmazó*]                                          NVARCHAR (255) NULL,
    [Megnevezés magyar (teljes _)*]                        NVARCHAR (255) NULL,
    [Megnevezés angol (teljes _)]                          NVARCHAR (255) NULL,
    [Megnevezés gyűjtőkódos]                               NVARCHAR (255) NULL,
    [áfa kulcs %]                                          NVARCHAR (255) NULL,
    [JAVASOLT FOGYASZTÓI ÁR érvényesség_-tól]              DATETIME       NULL,
    [JAVASOLT FOGYASZTÓI ÁR érvényesség_-ig]               NVARCHAR (255) NULL,
    [JAVASOLT FOGYASZTÓI ÁR Fogyasztói ár (bruttó)]        NVARCHAR (255) NULL,
    [DCMS beszerzési ár érvényesség_-tól1]                 DATETIME       NULL,
    [DCMS beszerzési ár érvényesség_-ig1]                  NVARCHAR (255) NULL,
    [DCMS beszerzési ár Beszerzési ár (nettó)]             NVARCHAR (255) NULL,
    [DCMS beszerzési ár kalkulált DCMS margin]             NVARCHAR (255) NULL,
    [TESCO felé közölt átadási ár érvényesség_-tól2]       DATETIME       NULL,
    [TESCO felé közölt átadási ár érvényesség_-ig2]        NVARCHAR (255) NULL,
    [TESCO felé közölt átadási ár Átadási ár (nettó)]      NVARCHAR (255) NULL,
    [TESCO felé közölt átadási ár kalkulált Tesco _margin] NVARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([PriceMastId] ASC)
);
GO

