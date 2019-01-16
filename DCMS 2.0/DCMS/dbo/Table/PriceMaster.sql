CREATE TABLE [dbo].[PriceMaster] (
    [Forgalmazó*]                                          NVARCHAR (255) NULL,
    [EAN*]                                                 FLOAT (53)     NULL,
    [Gyűtő EAN]                                            NVARCHAR (255) NULL,
    [TPN]                                                  FLOAT (53)     NULL,
    [Megnevezés magyar (teljes _)*]                        NVARCHAR (255) NULL,
    [Megnevezés angol (teljes _)]                          NVARCHAR (255) NULL,
    [Megnevezés gyűjtőkódos]                               NVARCHAR (255) NULL,
    [áfa kulcs %]                                          FLOAT (53)     NULL,
    [JAVASOLT FOGYASZTÓI ÁR érvényesség_-tól]              DATETIME       NULL,
    [JAVASOLT FOGYASZTÓI ÁR érvényesség_-ig]               NVARCHAR (255) NULL,
    [JAVASOLT FOGYASZTÓI ÁR Fogyasztói ár (bruttó)]        FLOAT (53)     NULL,
    [DCMS beszerzési ár érvényesség_-tól1]                 DATETIME       NULL,
    [DCMS beszerzési ár érvényesség_-ig1]                  NVARCHAR (255) NULL,
    [DCMS beszerzési ár Beszerzési ár (nettó)]             FLOAT (53)     NULL,
    [DCMS beszerzési ár kalkulált DCMS margin]             FLOAT (53)     NULL,
    [TESCO felé közölt átadási ár érvényesség_-tól2]       DATETIME       NULL,
    [TESCO felé közölt átadási ár érvényesség_-ig2]        NVARCHAR (255) NULL,
    [TESCO felé közölt átadási ár Átadási ár (nettó)]      FLOAT (53)     NULL,
    [TESCO felé közölt átadási ár kalkulált Tesco _margin] FLOAT (53)     NULL
);
GO

