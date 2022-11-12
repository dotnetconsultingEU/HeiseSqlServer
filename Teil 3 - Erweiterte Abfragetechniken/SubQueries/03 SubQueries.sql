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

-- Alle Spalten und eine Nummerierung ausgeben
SELECT 
	ROW_NUMBER() OVER (PARTITION BY [name] ORDER BY [id] ) AS 'Nr',
	*
FROM [dbo].[Personenverzeichnis] [pv];

-- F�r z.B. Einschr�nkungen auf ROW_NUMBER() muss die gesamte Abfrage
-- als Unterabfrage gekapselt werden
SELECT * FROM 
(
	SELECT 
		ROW_NUMBER() OVER (PARTITION BY [name] ORDER BY [id] ) AS 'Nr',
		*
	FROM [dbo].[Personenverzeichnis] [pv]
) _ ; 
-- Der Unterscore ('_') ist ein Alias der vorhanden sein muss auch wenn
-- er nicht verwendet wird, sonst gibt es einen Fehler

-- Damit kann gefiltert (oder auch sortiert, etc.) werden
SELECT * FROM 
(
	SELECT 
		ROW_NUMBER() OVER (PARTITION BY [name] ORDER BY [id] ) AS 'Nr',
		*
	FROM [dbo].[Personenverzeichnis] [pv]
) _ 
WHERE Nr = 1;