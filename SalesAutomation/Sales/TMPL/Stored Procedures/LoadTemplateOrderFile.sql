CREATE PROCEDURE [TMPL].[LoadTemplateOrderFile]
	@Path as NVARCHAR(1000)
AS

	DECLARE @EventDate DATE;
	DECLARE @OrderId INT;

	EXEC [TMPL].GetTemplateEventDate @Path;

	SET @EventDate = (SELECT StartDate FROM dbo.FileLoad WHERE [Path] = @Path AND IsLoaded = 0);

	EXEC [TMPL].[CreateOrder] @EventDate, @OrderId OUTPUT;

	EXEC [TMPL].LoadTemplateOrderData @Path;
	EXEC [TMPL].MigrateTemplateOrderData @Path, @OrderId;

	EXEC [TMPL].[CalculateNewOrderAllocation] @OrderId;

	UPDATE dbo.FileLoad
	SET IsLoaded = 1
	WHERE Path = @Path AND IsLoaded = 0;

RETURN 0