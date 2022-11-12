-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank wechseln
USE [dotnetconsulting_Videogames];


-- Ziel anlegen (darf nicht existieren, Recht muss vorhanden sein) und befüllen
SELECT [Name], 
	   COUNT(*) AS 'Anzahl'
	   INTO [dbo].[NamenVerteilung]
FROM [dbo].[Spieler]
GROUP BY [Name]
ORDER BY 2 DESC;

-- Test
SELECT * FROM [dbo].[NamenVerteilung];

-- Möglich sind auch temporäre Tabellen
DROP TABLE IF EXISTS #tmpNamenVerteilung;

SELECT [Name], 
	   COUNT(*) AS 'Anzahl'
	   INTO #tmpNamenVerteilung
FROM [dbo].[Spieler]
GROUP BY [Name]
ORDER BY 2 DESC;

-- Test
SELECT * FROM #tmpNamenVerteilung;