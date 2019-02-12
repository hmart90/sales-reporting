CREATE PROCEDURE [dbo].[CheckFolderContent]
	@folderpath nvarchar(500),
	@type nvarchar(50),
	@salesorstock nvarchar(50)
AS

	TRUNCATE TABLE dbo.TempFiles;

	DECLARE @sql nvarchar(max);
	
	SET  @sql = 'INSERT INTO TempFiles EXECUTE xp_cmdshell ''dir "' + @folderpath + '" /b'''

	EXEC(@sql)
	
	DELETE tf
	FROM dbo.TempFiles as tf
	INNER JOIN dbo.FileNamePath AS fnp ON (@folderpath + '\' + tf.FileName) = fnp.[FilenamePath]

	INSERT INTO dbo.FileNamePath
		(	[Filename],
			[Path] ,
			[FilenamePath],
			[Type],
			[SalesOrStock])
	SELECT 
			FileName,
			@folderpath,
			@folderpath + '\' + FileName,
			@type,
			@salesorstock

	FROM dbo.TempFiles
	
	WHERE FileName IS NOT NULL


RETURN 0
