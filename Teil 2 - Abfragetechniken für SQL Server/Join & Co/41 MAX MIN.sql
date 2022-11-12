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

-- Datum, an dem sich ein Spieler zuletzt angemeldet hat
SELECT MAX([MitgliedSeit]) FROM [dbo].[Spieler];

-- ... als erstes
SELECT MIN([MitgliedSeit]) FROM [dbo].[Spieler];

-- Beides zusammen
SELECT MIN([MitgliedSeit]) AS 'Letzter',
       MAX([MitgliedSeit]) AS 'Erster'
FROM [dbo].[Spieler];

-- Durchschnittliche Punktezahl - Fehler?
SELECT AVG([Punkte]) FROM [dbo].[Highscores];

-- Die Zahlen sind zu groß...
SELECT AVG(CAST([Punkte] AS BIGINT)) FROM [dbo].[Highscores];
