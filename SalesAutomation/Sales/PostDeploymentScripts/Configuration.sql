EXEC sp_configure 'external scripts enabled',1
RECONFIGURE WITH OVERRIDE
GO
EXEC sp_configure 'clr enabled', 1  
GO  
RECONFIGURE WITH OVERRIDE
GO