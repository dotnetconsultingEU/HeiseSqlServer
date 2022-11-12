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

SELECT *, -- Spalten wie gewöhnlich auswählen
	-- In Klammern kann die skalare Rückgabe einer Unterabfrage 
	-- als Spalte verwendet werden
	(SELECT MAX(LEN([name])) FROM [dbo].[Personenverzeichnis]) AS 'Maximale Länge'
FROM [dbo].[Personenverzeichnis];

SELECT *, -- Spalten wie gewöhnlich auswählen
	-- Die Unterabfrage kann durch die Hauptabfrage eingeschränkt werden 
	(SELECT COUNT(*) FROM [dbo].[Personenverzeichnis] WHERE [Name] = [pv].[Name]) AS 'Anzahl des Namens'
FROM [dbo].[Personenverzeichnis] [pv];

-- Damit lassen sich gleiche Namen in der Forma "x von y" durchnummerieren
SELECT *, -- Spalten wie gewöhnlich auswählen
	-- Die Unterabfrage kann durch die Hauptabfrage eingeschränkt werden 
	ROW_NUMBER() OVER (PARTITION BY [name] ORDER BY [id]) AS 'Akt Nr',
	(SELECT COUNT(*) FROM [dbo].[Personenverzeichnis] WHERE [Name] = [pv].[Name]) AS 'Anzahl des Namens'
FROM [dbo].[Personenverzeichnis] [pv];

-- Damit lassen sich gleiche Namen in der Form "x von y" durchnummerieren
SELECT 
	CONCAT(ROW_NUMBER() OVER (PARTITION BY [name] ORDER BY [id] ), 
		   ' von ',
	       (SELECT COUNT(*) FROM [dbo].[Personenverzeichnis] WHERE [Name] = [pv].[Name])
		  ) AS 'Nummerierung', 
	[Name],
	IDENTITYCOL
FROM [dbo].[Personenverzeichnis] [pv];