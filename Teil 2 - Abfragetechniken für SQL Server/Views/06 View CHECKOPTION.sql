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

-- Tabelle anlegen
CREATE TABLE [dbo].[Tickets]
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	[Status] VARCHAR(50) NOT NULL,
	TraceID INT NOT NULL
);
GO

-- Ein paar Zeilen einfügen
INSERT  [dbo].[Tickets]
        ([Status], TraceID)
VALUES  ('ut estis quorum Multum in quo, e non quad esset', 22),
        ('ut novum transit. cognitio, in regit, delerium.', 23),
        ('in plorum sed quantare eudis transit. et quo pars', 24),
        ('rarendum vobis transit. travissimantor pladior et', 123),
        ('pladior si non Et si e esset linguens vobis', 112),
        ('homo, non transit. novum nomen in non quantare non', 44);

-- View anlegen
GO
CREATE VIEW [dbo].[vwView]
AS
	SELECT [ID],
           [Status],
           [TraceID] FROM  [dbo].[Tickets]
	WHERE TraceID < 100
	WITH CHECK OPTION;

-- Abfrage
SELECT * FROM [dbo].[vwView];
UPDATE [dbo].[vwView] SET TraceID = 200; -- Änderungen aus dem Filter heraus
UPDATE [dbo].[vwView] SET TraceID = 10; -- Änderungen innerhalb des Filters
