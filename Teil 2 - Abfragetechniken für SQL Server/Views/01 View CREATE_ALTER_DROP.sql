-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, das eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank (erneut) anlegen und wechseln
-- Achtung! SQLCMD-Mode
:SETVAR dbname dotnetconsulting_Views
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

-- View anlegen
CREATE VIEW [dbo].[vwView]
AS
	SELECT * FROM [sys].[databases]
	WHERE [source_database_id] IS NULL;
GO

-- View ändern
ALTER VIEW [dbo].[vwView]
AS
	SELECT * FROM [sys].[databases]
	WHERE NOT [source_database_id] IS NULL;

-- Ab SQL Server 2016: View anlegen oder ändern (wenn schon vorhanden)
CREATE OR ALTER VIEW [dbo].[vwView]
AS
	SELECT * FROM [sys].[databases]
	WHERE [source_database_id] IS NULL;
GO

-- View löschen
IF NOT OBJECT_ID('[dbo].[vwView]', 'V') IS NULL
	DROP VIEW [dbo].[vwView];

-- Ab SQL Server 2016: View löschen wenn schon vorhanden
DROP VIEW IF EXISTS [dbo].[vwView];
