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
CREATE PROC [dbo].[usp_StoredProcedure_Return] 
	@P1 INT,
	@P2 INT
AS
BEGIN	
	IF @P2 = 0 
		RETURN; -- Ende der Verarbeitung und R�ckgabe von 0
		
	-- R�ckgabe von Ergebnismengen durch SELECT
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
