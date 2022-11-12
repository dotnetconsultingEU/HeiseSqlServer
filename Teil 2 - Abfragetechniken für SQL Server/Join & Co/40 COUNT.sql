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

-- Nur eindeutige Zeilen zurückliefern
SELECT DISTINCT [Name] FROM [dbo].[Spieler];

-- Wieviele Spieler sind in der Datenbank gespeichert?
SELECT COUNT(*) FROM [dbo].[Spieler];

SELECT COUNT(ALL Name) FROM [dbo].[Spieler];

-- Mit Alias
SELECT COUNT(ALL Name) AS 'Spieleranzahl' FROM [dbo].[Spieler];

-- Wieviele unterschiedliche/eindeutige Namen gibt es?
SELECT COUNT(DISTINCT Name) AS 'Spieleranzahl' FROM [dbo].[Spieler];
