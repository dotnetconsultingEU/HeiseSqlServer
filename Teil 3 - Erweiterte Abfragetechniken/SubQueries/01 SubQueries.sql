-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Es wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen steht der Autor gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- In Datenbank wechseln
USE dotnetconsulting_TSQL2;
GO

-- Wieviele Datensätze gibt es in der Tabelle?
SELECT COUNT(*) FROM [dbo].[Personenverzeichnis];

-- Wieviele eindeutige Namen sind darunter?
SELECT COUNT(DISTINCT [NAME]) FROM [dbo].[Personenverzeichnis];

-- Wieviel Prozent entspricht das?
SELECT FORMAT(CAST(COUNT(DISTINCT [NAME]) AS DECIMAL) / COUNT(*), 'P') 
FROM [dbo].[Personenverzeichnis];

-- So weit, so gut. Aber was machen, wenn Zeilen berücksichtig werden soll?
DECLARE @StartWith CHAR(1) = 'A'

SELECT FORMAT(CAST(COUNT(DISTINCT [NAME]) AS DECIMAL) / COUNT(*), 'P') 
FROM
(
	SELECT * FROM [dbo].[Personenverzeichnis] WHERE [Name] LIKE @StartWith + '%'
) [_];
