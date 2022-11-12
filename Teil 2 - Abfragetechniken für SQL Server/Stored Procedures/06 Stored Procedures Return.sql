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
CREATE PROC [dbo].[usp_StoredProcedure_Return] 
	@P1 INT,
	@P2 INT
AS
BEGIN	
	IF @P2 = 0 
		RETURN; -- Ende der Verarbeitung und Rückgabe von 0
		
	-- Rückgabe von Ergebnismengen durch SELECT
	SELECT * FROM sys.databases;
	
	SELECT * FROM sys.servers;	

	RETURN @P1 / @P2;
END;
GO

-- Aufruf
EXEC [dbo].[usp_StoredProcedure_Return] @P1 = 33, @P2 = 11;

DECLARE @result INT = 99;

EXEC @result = [dbo].[usp_StoredProcedure_Return] @P1 = 33, @P2 = 0;
PRINT @result;

EXEC @result = [dbo].[usp_StoredProcedure_Return] @P1 = 33, @P2 = 11;
PRINT @result;
