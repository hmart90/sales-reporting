CREATE PROCEDURE [dbo].[GetExcelSheetName]
	@excelFileUrl nvarchar(1000)
AS

BEGIN
	
	-- Get table (worksheet) or column (field) listings from an excel spreadsheet

	DECLARE @linkedServerName sysname = 'TempExcelSpreadsheet'
	DECLARE @sheetname nvarchar(500);

	IF OBJECT_ID('tempdb..#MyTempTable') IS NOT NULL
	DROP TABLE #MyTempTable;

	-- Remove existing linked server (if necessary)
	if exists(select null from sys.servers where name = @linkedServerName) begin
	exec sp_dropserver @server = @linkedServerName, @droplogins = 'droplogins'
	end

	-- Add the linked server
	-- ACE 12.0 seems to work for both xsl and xslx, though some might prefer the older JET provider
	exec sp_addlinkedserver
	@server = @linkedServerName,
	@srvproduct = 'ACE 12.0',
	@provider = 'Microsoft.ACE.OLEDB.12.0',
	@datasrc = @excelFileUrl,
	@provstr = 'Excel 12.0;HDR=Yes'

	-- Grab the current user to use as a remote login
	DECLARE @suser_sname NVARCHAR(256) = SUSER_SNAME()

	-- Add the current user as a login
	EXEC SP_ADDLINKEDSRVLOGIN
	@rmtsrvname = @linkedServerName,
	@useself = 'false',
	@locallogin = @suser_sname,
	@rmtuser = null,
	@rmtpassword = null

	-- Return the table info, each worksheet pbb gets its own unique name
	SELECT * INTO #MyTempTable FROM OPENROWSET('SQLNCLI', 'Server=(local);Trusted_Connection=yes;',
	'EXEC sp_tables_ex TempExcelSpreadsheet');

	SET @sheetname = (	SELECT TOP 1 RIGHT(LEFT(TABLE_NAME,len(TABLE_NAME)-2),len(TABLE_NAME)-3)
						FROM #MyTempTable
						ORDER By len(TABLE_NAME) DESC)

	--exec sp_executesql 'SELECT * INTO #MyTempTable FROM OPENROWSET(''SQLNCLI'', ''Server=(local);Trusted_Connection=yes;'',''EXEC sp_tables_ex TempExcelSpreadsheet'')'
	--EXEC sp_tables_ex @linkedServerName
	--EXEC sp_columns_ex @linkedServerName

	-- Remove temp linked server
	if exists(select null from sys.servers where name = @linkedServerName) begin
	exec sp_dropserver @server = @linkedServerName, @droplogins = 'droplogins'
	end

	UPDATE dbo.FileNamePath
	SET SheetName = @sheetname
	WHERE FilenamePath = @excelFileUrl

	SELECT @sheetname as SheetName

END

RETURN 0
