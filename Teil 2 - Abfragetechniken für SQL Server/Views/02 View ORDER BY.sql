-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, das eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank (erneut) anlegen und wechseln
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

-- View anlegen (So aber leider nicht!)
CREATE VIEW [dbo].[vwView_OrderBy]
AS
	SELECT [name],
           [database_id]
	FROM [sys].[databases]
	ORDER BY [name];

-- So vielleicht? Ja, aber welche Anzahl soll für Top verwendet werden?
-- 10 (und jeder anderer Wert) ist schon ein wenig willkürlich (bis SQL Server 2016!)
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
-- Aber aus ungekannten Gründen wird die Sortierung nun komplett ignoriert ;-(
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