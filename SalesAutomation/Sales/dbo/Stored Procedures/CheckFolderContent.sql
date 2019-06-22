CREATE PROCEDURE [dbo].[CheckFolderContent]
	@folderpath nvarchar(500)
AS

	TRUNCATE TABLE dbo.TempDirectoryContent;

	DECLARE @sql nvarchar(max);
	
	SET  @sql = 'INSERT INTO dbo.TempDirectoryContent EXECUTE xp_cmdshell ''dir "' + @folderpath + '" /b'''

	EXEC(@sql)
	
	DELETE tf
	FROM dbo.TempDirectoryContent as tf
	INNER JOIN dbo.FileLoad AS fnp ON tf.Name = fnp.[Name]

	INSERT INTO dbo.FileLoad
		(	[Name],
			[Path])
	SELECT 
			Name,
			@folderpath + '\' + Name

	FROM dbo.TempDirectoryContent
	
	WHERE Name IS NOT NULL


RETURN 0