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
CREATE PROCEDURE [dbo].[usp_StoredProcedure_DumpTempTable]
AS
BEGIN
    SET NOCOUNT ON;

	-- Ausgabe zum Test
	SELECT * FROM #t1;
END;
GO

-- Stored Procedure anlegen
CREATE PROCEDURE [dbo].[usp_StoredProcedure_TempTable]
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @t INT = 99;

	-- Tempor�re Tabelle in der SP erstellen
	-- Diese MUSS nicht in der SP gel�scht werden 
	SELECT * INTO #t1 FROM [sys].[databases] ORDER BY [name]

	-- Ausgabe zum Test
	-- F�r diese SP ist die Temp Tabelle vorhanden
	EXEC [dbo].[usp_StoredProcedure_DumpTempTable];
END;
GO

-- Aufruf
EXEC [dbo].[usp_StoredProcedure_TempTable]; 

-- Temp Tabelle nicht (mehr) vorhanden
SELECT * FROM #t1;
