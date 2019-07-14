CREATE PROCEDURE [dbo].[GetFileLoadType]
	@Path NVARCHAR(1000)

AS

DECLARE @SQL AS NVARCHAR(MAX);
DECLARE @CycleDone INT = 0;
DECLARE @FileLoadType as nvarchar(500);
DECLARE @SheetName as nvarchar(500);
DECLARE @CellValue as nvarchar(1000);
DECLARE @RightSheetCount as int;
EXEC dbo.GetExcelSheets @Path;
SET @FileLoadType = 'Not found';

SET @RightSheetCount = (SELECT COUNT(TempExcelSheetId) FROM dbo.TempExcelSheet WHERE SheetName = 'Nyitó készlet')

IF @RightSheetCount = 1
	BEGIN
		TRUNCATE TABLE dbo.TempFileType;
		SET @SQL = '
		INSERT INTO [dbo].[TempFileType]
				   ([Value])
		SELECT *

		FROM OPENROWSET(
			''Microsoft.ACE.OLEDB.12.0''
			,''Excel 12.0;Database=' + @Path + ';HDR=NO''
			,''SELECT * FROM [Summary$A9:A9]'')';
		EXEC (@SQL);
		SET @CellValue = (SELECT TOP 1 [Value] FROM dbo.TempFileType);

		IF @CellValue = 'A hét nyító készlete'
			BEGIN
				SET @FileLoadType = 'FinanceReport';
				SET @CycleDone = 1;
			END
		ELSE
			BEGIN
				SET @CycleDone = 0;
			END
	END

SET @RightSheetCount = (SELECT COUNT(TempExcelSheetId) FROM dbo.TempExcelSheet WHERE SheetName LIKE 'Gaming%' OR SheetName LIKE 'DVD%');
SET @SheetName = (SELECT TOP 1 SheetName FROM dbo.TempExcelSheet WHERE SheetName LIKE 'Gaming%' OR SheetName LIKE 'DVD%');
IF @RightSheetCount > 0
BEGIN
	IF @CycleDone = 0
		BEGIN
			TRUNCATE TABLE dbo.TempFileType;
			SET @SQL = '
			INSERT INTO [dbo].[TempFileType]
					   ([Value])
			SELECT *

			FROM OPENROWSET(
				''Microsoft.ACE.OLEDB.12.0''
				,''Excel 12.0;Database=' + @Path + ';HDR=NO''
				,''SELECT * FROM [' + @SheetName + '$J4:J4]'')';
			EXEC (@SQL);
			SET @CellValue = (SELECT TOP 1 [Value] FROM dbo.TempFileType);

			IF @CellValue = 'Sold units'
				BEGIN
					SET @FileLoadType = 'MSTRSales';
					SET @CycleDone = 1;
				END
			ELSE
				BEGIN
					SET @CycleDone = 0;
				END
		END

	IF @CycleDone = 0
		BEGIN
			TRUNCATE TABLE dbo.TempFileType;
			SET @SQL = '
			INSERT INTO [dbo].[TempFileType]
					   ([Value])
			SELECT *

			FROM OPENROWSET(
				''Microsoft.ACE.OLEDB.12.0''
				,''Excel 12.0;Database=' + @Path + ';HDR=NO''
				,''SELECT * FROM [' + @SheetName + '$K4:K4]'')';
			EXEC (@SQL);
			SET @CellValue = (SELECT TOP 1 [Value] FROM dbo.TempFileType);

			IF @CellValue = 'Stock units (Daily Shops)'
				BEGIN
					SET @FileLoadType = 'MSTRStock';
					SET @CycleDone = 1;
				END
			ELSE
				BEGIN
					SET @CycleDone = 0;
				END
		END

	IF @CycleDone = 0
		BEGIN
			TRUNCATE TABLE dbo.TempFileType;
			SET @SQL = '
			INSERT INTO [dbo].[TempFileType]
					   ([Value])
			SELECT *

			FROM OPENROWSET(
				''Microsoft.ACE.OLEDB.12.0''
				,''Excel 12.0;Database=' + @Path + ';HDR=NO''
				,''SELECT * FROM [' + @SheetName + '$L4:L4]'')';
			EXEC (@SQL);
			SET @CellValue = (SELECT TOP 1 [Value] FROM dbo.TempFileType);

			IF @CellValue = 'Stock units (Daily Shops)'
				BEGIN
					SET @FileLoadType = 'MSTRStock';
					SET @CycleDone = 1;
				END
			ELSE
				BEGIN
					SET @CycleDone = 0;
				END
		END

END

SET @RightSheetCount = (SELECT COUNT(TempExcelSheetId) FROM dbo.TempExcelSheet WHERE SheetName LIKE 'endelé')

IF @RightSheetCount = 1
	BEGIN
		TRUNCATE TABLE dbo.TempFileType;
		SET @SQL = '
		INSERT INTO [dbo].[TempFileType]
				   ([Value])
		SELECT *

		FROM OPENROWSET(
			''Microsoft.ACE.OLEDB.12.0''
			,''Excel 12.0;Database=' + @Path + ';HDR=NO''
			,''SELECT * FROM [rendelés$A1:A1]'')';
		EXEC (@SQL);
		SET @CellValue = (SELECT TOP 1 [Value] FROM dbo.TempFileType);

		IF @CellValue = 'Order'
			BEGIN
				SET @FileLoadType = 'TemplateOrder';
				SET @CycleDone = 1;
			END
		ELSE
			BEGIN
				SET @CycleDone = 0;
			END
	END

SET @RightSheetCount = (SELECT COUNT(TempExcelSheetId) FROM dbo.TempExcelSheet WHERE SheetName LIKE 'unka')

IF @RightSheetCount = 1
	BEGIN
		TRUNCATE TABLE dbo.TempFileType;
		SET @SQL = '
		INSERT INTO [dbo].[TempFileType]
				   ([Value])
		SELECT *

		FROM OPENROWSET(
			''Microsoft.ACE.OLEDB.12.0''
			,''Excel 12.0;Database=' + @Path + ';HDR=NO''
			,''SELECT * FROM [Munka1$H1:H1]'')';
		EXEC (@SQL);
		SET @CellValue = (SELECT TOP 1 [Value] FROM dbo.TempFileType);

		IF @CellValue = 'Store number'
			BEGIN
				SET @FileLoadType = 'Range';
				SET @CycleDone = 1;
			END
		ELSE
			BEGIN
				SET @CycleDone = 0;
			END
	END


SET @RightSheetCount = (SELECT COUNT(TempExcelSheetId) FROM dbo.TempExcelSheet WHERE SheetName LIKE 'rváltozá')

IF @RightSheetCount = 1
	BEGIN
		TRUNCATE TABLE dbo.TempFileType;
		SET @SQL = '
		INSERT INTO [dbo].[TempFileType]
				   ([Value])
		SELECT *

		FROM OPENROWSET(
			''Microsoft.ACE.OLEDB.12.0''
			,''Excel 12.0;Database=' + @Path + ';HDR=NO''
			,''SELECT * FROM [árváltozás$H2:H2]'')';
		EXEC (@SQL);
		SET @CellValue = (SELECT TOP 1 [Value] FROM dbo.TempFileType);

		IF @CellValue  LIKE 'Érvényességi dátum kezdet%'
			BEGIN
				SET @FileLoadType = 'TemplatePrice';
				SET @CycleDone = 1;
			END
		ELSE
			BEGIN
				SET @CycleDone = 0;
			END
	END




SELECT @FileLoadType as FileType


RETURN 0
