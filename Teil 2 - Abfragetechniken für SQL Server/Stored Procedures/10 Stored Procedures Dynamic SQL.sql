-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, das eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank (erneut) anlegen und wechseln
:SETVAR dbname dotnetconsulting_StoredProcedures
USE [master];
IF EXISTS (SELECT * FROM [sys].[databases] WHERE [name] = '$(dbname)')
BEGIN
	ALTER DATABASE [$(dbname)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE [$(dbname)];
	PRINT '''$(dbname)''-Datenbank gelöscht';
END
GO
CREATE DATABASE [$(dbname)];
GO
USE [$(dbname)];
PRINT '''$(dbname)''-Datenbank erstellt und gewechselt';
GO

CREATE OR ALTER PROC [dbo].[usp_DumpTable]
	@tablename sysname,
	@schemaname sysname = 'dbo'
AS
BEGIN
	DECLARE @sql NVARCHAR(MAX) = 
		CONCAT(N'SELECT * FROM ', QUOTENAME(@schemaname), N'.', QUOTENAME(@tablename), N';');
	SET CONCAT_NULL_YIELDS_NULL, ARITHABORT, ANSI_NULLS, QUOTED_IDENTIFIER ON;

	-- "Debug"-Print
	PRINT @sql;

	--EXEC [sp_executesql] @sql;
	EXEC (@sql);
END
GO

-- Aufruf
EXEC [dbo].[usp_DumpTable] @tablename = 'databases', @schemaname = 'sys';

-- Compile aus Wunsch
EXEC sp_recompile '[dbo].[usp_DumpTable]'