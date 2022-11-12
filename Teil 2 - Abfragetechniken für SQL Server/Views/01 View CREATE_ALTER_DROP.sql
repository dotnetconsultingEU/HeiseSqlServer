-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Jedoch wird keine Garantie �bernommen, das eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen stehe ich jedoch gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank (erneut) anlegen und wechseln
-- Achtung! SQLCMD-Mode
:SETVAR dbname dotnetconsulting_Views
USE [master];
IF EXISTS (SELECT * FROM [sys].[databases] WHERE [name] = '$(dbname)')
BEGIN
	ALTER DATABASE [$(dbname)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE [$(dbname)];
	PRINT '''$(dbname)''-Datenbank gel�scht';
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

-- View �ndern
ALTER VIEW [dbo].[vwView]
AS
	SELECT * FROM [sys].[databases]
	WHERE NOT [source_database_id] IS NULL;

-- Ab SQL Server 2016: View anlegen oder �ndern (wenn schon vorhanden)
CREATE OR ALTER VIEW [dbo].[vwView]
AS
	SELECT * FROM [sys].[databases]
	WHERE [source_database_id] IS NULL;
GO

-- View l�schen
IF NOT OBJECT_ID('[dbo].[vwView]', 'V') IS NULL
	DROP VIEW [dbo].[vwView];

-- Ab SQL Server 2016: View l�schen wenn schon vorhanden
DROP VIEW IF EXISTS [dbo].[vwView];
