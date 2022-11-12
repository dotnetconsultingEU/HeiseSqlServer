-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Jedoch wird keine Garantie �bernommen, das eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen stehe ich jedoch gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank (erneut) anlegen und wechseln
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

-- View anlegen (So aber leider nicht!)
CREATE VIEW [dbo].[vwView_OrderBy]
AS
	SELECT [name],
           [database_id]
	FROM [sys].[databases]
	ORDER BY [name];

-- So vielleicht? Ja, aber welche Anzahl soll f�r Top verwendet werden?
-- 10 (und jeder anderer Wert) ist schon ein wenig willk�rlich (bis SQL Server 2016!)
CREATE VIEW [dbo].[vwView_OrderBy]
AS
	SELECT TOP 10 
		   [name],
           [database_id]
	FROM [sys].[databases]
	ORDER BY [database_id];
GO
SELECT * FROM [dbo].[vwView_OrderBy]

-- Dann doch lieber 100 Prozent
-- Aber aus ungekannten Gr�nden wird die Sortierung nun komplett ignoriert ;-(
ALTER VIEW [dbo].[vwView_OrderBy]
AS
	SELECT TOP 100 PERCENT 
		   [name],
           [database_id]
	FROM [sys].[databases]
	ORDER BY [name];
GO
SELECT * FROM [dbo].[vwView_OrderBy];

-- Vielleicht dann so? In der Tat so funktioniert es so.
-- Trotzdem sind ORDER BY-Klauseln in Views nicht optimal

CREATE OR ALTER VIEW [dbo].[vwView_OrderBy]
AS
	SELECT TOP (SELECT COUNT(*) FROM [sys].[databases]) 
		   [name],
           [database_id]
	FROM [sys].[databases]
	ORDER BY [name];
GO
SELECT * FROM [dbo].[vwView_OrderBy];