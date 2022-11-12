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

-- Eine Zeile löschen
DELETE [dbo].[Spieler]
WHERE [ID] = 3; -- Einschränkung ist meistens(!) sinnvoll

-- Test
SELECT * FROM [dbo].[Spieler] WHERE [ID] = 3;


-- Alle Zeilen löschen
DELETE [dbo].[Spieler];

-- Test. Ups...
SELECT * FROM [dbo].[Spieler];


-- Spieler löschen, die keinen Highscore haben?
DELETE [dbo].[Spieler]
WHERE NOT ID IN (SELECT [SpielerID] FROM [dbo].[Highscores]);