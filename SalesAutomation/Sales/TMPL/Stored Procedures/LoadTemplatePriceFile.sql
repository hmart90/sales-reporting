CREATE PROCEDURE [TMPL].[LoadTemplatePriceFile]
	@Path as NVARCHAR(1000)
AS

	EXEC [TMPL].LoadTemplatePriceData @Path;
	EXEC [TMPL].MigrateTemplatePriceData @Path;

	UPDATE dbo.FileLoad
	SET IsLoaded = 1
	WHERE Path = @Path AND IsLoaded = 0;

RETURN 0
