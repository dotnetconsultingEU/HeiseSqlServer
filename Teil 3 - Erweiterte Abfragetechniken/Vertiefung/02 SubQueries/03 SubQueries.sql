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

-- Alle Spalten und eine Nummerierung ausgeben
SELECT 
	ROW_NUMBER() OVER (PARTITION BY [name] ORDER BY [id] ) AS 'Nr',
	*
FROM [dbo].[Personenverzeichnis] [pv];

-- Für z.B. Einschränkungen auf ROW_NUMBER() muss die gesamte Abfrage
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