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
CREATE PROC [dbo].[usp_StoredProcedure_Latebinding] 
AS
BEGIN	
	-- Syntax wird bei der Erstellung der Stored Procedure gepr�ft
	-- SLECT * FROM [sys].[databases] -- => Fehler

	-- Ist die Quelle nicht vorhanden, wird die Stored Procedure trotzdem erstellt
	-- Zur Laufzeit muss die Quelle nat�rlich vorhanden sein!
	SELECT a,c,b,d,e FROM [sys].[databases2] 

	-- Gleiches gilt auch f�r andere Objekte wie Prozeduren
	-- EXEC dbo.usp_WasAuchImmer;

	-- Ist die Quelle vorhanden, m�ssen auch Spalten exisiteren 
    SELECT  [name],
			--[name2], -- Spalte nicht vorhanden
            [database_id],
            [source_database_id]
            [create_date]
    FROM    [sys].[databases];
END;
GO

-- Stored Procedure anlegen. Die Tempor�re Tabelle gibt es aktuell (noch) nicht
CREATE PROC [dbo].[usp_StoredProcedure_Latebinding2] 
AS
BEGIN	
	SELECT * FROM #t1;
END;
GO

-- Tempor�re Tabelle erstellen
SELECT * INTO #t1 FROM [sys].[databases];

-- SP aufrufen, SP wird kompiliert
EXEC  [dbo].[usp_StoredProcedure_Latebinding2];
GO

-- Tempor�re Tabelle l�schen und neu erstellen
IF NOT OBJECT_ID('tempdb..#t1','U') IS NULL
	DROP TABLE #t1;

SELECT * INTO #t1 FROM [sys].[syslogins];

-- SP wieder aufrufen, SP wird wieder kompiliert
EXEC  [dbo].[usp_StoredProcedure_Latebinding2];
