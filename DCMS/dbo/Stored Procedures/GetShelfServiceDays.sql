CREATE PROCEDURE [dbo].[GetShelfServiceDays]
AS
BEGIN

	SELECT [Riport ID]
		  ,[Feladat]
		  ,[Túranap]
		  ,[Kód]
		  ,[Áruház]
		  ,[Polcszervizes]
		  ,[Polcos telefonszáma]
		  ,[A DVD-Gaming kategória hol található meg az áruházban?]
		  ,[Milyen szomszédos kategóriák találhatók mellette?]
		  ,[Fix, állandó modulok száma összesen?]
		  ,[Hány cm szélesek?]
		  ,[Hány db polcból állnak?]
		  ,[Találhatók egyéb állandó bútorok az eladótérben?]
		  ,[Pro Video displayek száma összesen?]
		  ,[Pro Video displayek helye?]
		  ,[Gamma displayek száma összesen?]
		  ,[Gamma  displayek helye?]
		  ,[Megjegyzés]
		  ,s.[Local Store format 2] AS [Store Size]
	  FROM [DCMS].[dbo].[ShelfServiceDay] as ssd

	  INNER JOIN dbo.Shop as s ON s.[Local Store Store code] = ssd.[Kód]

END
