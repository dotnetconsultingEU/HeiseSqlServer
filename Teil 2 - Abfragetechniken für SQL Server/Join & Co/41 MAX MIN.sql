-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Jedoch wird keine Garantie �bernommen, dass eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen stehe ich jedoch gerne zur Verf�gung.
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

-- Die Zahlen sind zu gro�...
SELECT AVG(CAST([Punkte] AS BIGINT)) FROM [dbo].[Highscores];
