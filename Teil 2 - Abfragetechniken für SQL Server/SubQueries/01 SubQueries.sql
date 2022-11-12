-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Es wird keine Garantie �bernommen, dass eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen steht der Autor gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- In Datenbank wechseln
USE dotnetconsulting_TSQL2;
GO

-- Wieviele Datens�tze gibt es in der Tabelle?
SELECT COUNT(*) FROM [dbo].[Personenverzeichnis];

-- Wieviele eindeutige Namen sind darunter?
SELECT COUNT(DISTINCT [NAME]) FROM [dbo].[Personenverzeichnis];

-- Wieviel Prozent entspricht das?
SELECT FORMAT(CAST(COUNT(DISTINCT [NAME]) AS DECIMAL) / COUNT(*), 'P') 
FROM [dbo].[Personenverzeichnis];

-- So weit, so gut. Aber was machen, wenn Zeilen ber�cksichtig werden soll?
DECLARE @StartWith CHAR(1) = 'A'

SELECT FORMAT(CAST(COUNT(DISTINCT [NAME]) AS DECIMAL) / COUNT(*), 'P') 
FROM
(
	SELECT * FROM [dbo].[Personenverzeichnis] WHERE [Name] LIKE @StartWith + '%'
) [_];
