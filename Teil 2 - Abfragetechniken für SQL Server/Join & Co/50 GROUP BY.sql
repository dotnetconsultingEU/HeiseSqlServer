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

-- Welcher Name kommt wie oft vor?
SELECT [Name], 
	   COUNT(*) AS 'Anzahl'
FROM [dbo].[Spieler]
GROUP BY [Name];

-- Mit Sortierung
SELECT [Name], 
	   COUNT(*) AS 'Anzahl'
FROM [dbo].[Spieler]
GROUP BY [Name]
ORDER BY 2 DESC;
