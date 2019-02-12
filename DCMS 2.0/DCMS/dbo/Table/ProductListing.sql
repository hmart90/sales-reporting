﻿CREATE TABLE [dbo].[ProductListing] (
    [EAN*]                          FLOAT (53)     NULL,
    [TPN*]                          FLOAT (53)     NULL,
    [EAN]                           FLOAT (53)     NULL,
    [Kategória]                     NVARCHAR (255) NULL,
    [Forgalmazó]                    NVARCHAR (255) NULL,
    [Gyűtő EAN]                     NVARCHAR (255) NULL,
    [Megnevezés magyar (teljes _)*] NVARCHAR (255) NULL,
    [Megnevezés angol (teljes _)]   NVARCHAR (255) NULL,
    [mélység (cm)*]                 FLOAT (53)     NULL,
    [szélesség (cm)*]               FLOAT (53)     NULL,
    [magasság (cm)*]                FLOAT (53)     NULL,
    [tömeg (kg)*]                   FLOAT (53)     NULL,
    [karton EAN]                    NVARCHAR (255) NULL,
    [darab / karton]                NVARCHAR (255) NULL,
    [szélesség (cm)]                NVARCHAR (255) NULL,
    [magasság (cm)]                 NVARCHAR (255) NULL,
    [mélység (cm)]                  NVARCHAR (255) NULL,
    [tömeg (kg)]                    NVARCHAR (255) NULL,
    [raklap EAN]                    NVARCHAR (255) NULL,
    [magasság (cm)1]                NVARCHAR (255) NULL,
    [tömeg (kg)1]                   NVARCHAR (255) NULL,
    [raklapsorok száma]             NVARCHAR (255) NULL,
    [platform*]                     NVARCHAR (255) NULL,
    [formátum*]                     NVARCHAR (255) NULL,
    [rendező]                       NVARCHAR (255) NULL,
    [főszereplők]                   NVARCHAR (255) NULL,
    [stúdió*]                       NVARCHAR (255) NULL,
    [műfaj*]                        NVARCHAR (255) NULL,
    [korhatár besorolás*]           NVARCHAR (255) NULL,
    [lemezek száma*]                NVARCHAR (255) NULL,
    [játékidő]                      NVARCHAR (255) NULL,
    [rögzítés dátuma]               NVARCHAR (255) NULL,
    [megjelenés dátuma]             NVARCHAR (255) NULL,
    [származási ország*]            NVARCHAR (255) NULL,
    [egyéb infó]                    NVARCHAR (255) NULL
);
GO

