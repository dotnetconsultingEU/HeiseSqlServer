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

-- Welche Namen sind doppelt?
SELECT [Name], 
	   COUNT(*) AS 'Anzahl'
FROM [dbo].[Spieler]
GROUP BY [Name]
HAVING COUNT(*) > 1;

-- Es sollen nur die Zeilen berücksichtigt werden, in denen der 
-- Name mit einem 'A' beginnt

SELECT [Name], 
	   COUNT(*) AS 'Anzahl'
FROM [dbo].[Spieler]
WHERE [Name] LIKE 'A%'
GROUP BY [Name]
HAVING COUNT(*) > 1;
