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

-- Stored Procedure anlegen
CREATE PROCEDURE [dbo].[usp_StoredProcedure]
	-- Parameter
AS
BEGIN
	-- Block
	SELECT 0;
END;
GO

-- Stored Procedure ändern
ALTER PROCEDURE [dbo].[usp_StoredProcedure]
	-- Parameter
AS
BEGIN
	-- Block
	SELECT 1;
END;
GO

-- Ab SQL Server 2016: Stored Procedure anlegen oder ändern (wenn schon vorhanden)
CREATE OR ALTER PROCEDURE [dbo].[usp_StoredProcedure]
	-- Parameter
AS
BEGIN
	-- Block
	SELECT 1;
END;
GO

-- Stored Procedure löschen
IF OBJECT_ID('[dbo].[usp_StoredProcedure]', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[usp_StoredProcedure];

-- Ab SQL Server 2016: Stored Procedure löschen wenn vorhanden
DROP PROCEDURE IF EXISTS [dbo].[usp_StoredProcedure];