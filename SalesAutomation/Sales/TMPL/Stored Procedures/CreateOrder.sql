CREATE PROCEDURE [TMPL].[CreateOrder]
	@EventDate AS DATE,
	@OrderId INT OUTPUT
AS

	UPDATE TMPL.[Order]
	SET IsActive = 0
	WHERE EventDate = @EventDate;

	INSERT INTO TMPL.[Order]
		(EventDate)
	VALUES
		(@EventDate);

	SET @OrderId = SCOPE_IDENTITY();

	SELECT @OrderId AS OrderId;

RETURN @OrderId
