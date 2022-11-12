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

-- Tabelle anlegen
CREATE TABLE [dbo].[Tickets]
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	[Status] VARCHAR(50) NOT NULL,
	TraceID INT NOT NULL
);
GO

-- Ein paar Zeilen einf�gen
INSERT  [dbo].[Tickets]
        ([Status], TraceID)
VALUES  ('ut estis quorum Multum in quo, e non quad esset', 22),
        ('ut novum transit. cognitio, in regit, delerium.', 23),
        ('in plorum sed quantare eudis transit. et quo pars', 24),
        ('rarendum vobis transit. travissimantor pladior et', 123),
        ('pladior si non Et si e esset linguens vobis', 112),
        ('homo, non transit. novum nomen in non quantare non', 44);
GO

-- View anlegen
CREATE VIEW [dbo].[vwView]
WITH ENCRYPTION
AS
	SELECT [ID],
           [Status],
           [TraceID] FROM  [dbo].[Tickets];
GO
-- View funktioniert wie erwartet
SELECT * FROM [dbo].[vwView];

-- Views vorhanden? Nat�rlich
SELECT * FROM sys.views

-- Quellcode des Views?
SELECT  
    m.definition    
FROM sys.views v
INNER JOIN sys.sql_modules m ON m.object_id = v.object_id
WHERE name = 'vwView';