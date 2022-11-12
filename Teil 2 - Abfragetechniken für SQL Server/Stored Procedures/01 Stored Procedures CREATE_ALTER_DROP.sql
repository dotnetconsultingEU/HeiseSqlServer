-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Jedoch wird keine Garantie �bernommen, das eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen stehe ich jedoch gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank (erneut) anlegen und wechseln
:SETVAR dbname dotnetconsulting_StoredProcedures
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

-- Stored Procedure anlegen
CREATE PROCEDURE [dbo].[usp_StoredProcedure]
	-- Parameter
AS
BEGIN
	-- Block
	SELECT 0;
END;
GO

-- Stored Procedure �ndern
ALTER PROCEDURE [dbo].[usp_StoredProcedure]
	-- Parameter
AS
BEGIN
	-- Block
	SELECT 1;
END;
GO

-- Ab SQL Server 2016: Stored Procedure anlegen oder �ndern (wenn schon vorhanden)
CREATE OR ALTER PROCEDURE [dbo].[usp_StoredProcedure]
	-- Parameter
AS
BEGIN
	-- Block
	SELECT 1;
END;
GO

-- Stored Procedure l�schen
IF OBJECT_ID('[dbo].[usp_StoredProcedure]', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[usp_StoredProcedure];

-- Ab SQL Server 2016: Stored Procedure l�schen wenn vorhanden
DROP PROCEDURE IF EXISTS [dbo].[usp_StoredProcedure];