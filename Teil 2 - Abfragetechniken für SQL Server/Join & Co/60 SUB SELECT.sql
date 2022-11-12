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

-- Unterabfragen k�nnen f�r Spalten verwendet werden
SELECT 
	(SELECT COUNT(*) FROM [dbo].[Highscores]) AS '# Highscore',
	(SELECT COUNT(*) FROM [dbo].[Spieler]) AS '# Spieler',
	(SELECT COUNT(*) FROM [dbo].[Laender]) AS '# L�nder';

SELECT 
	(SELECT MAX([Punkte]) FROM [dbo].[Highscores]) AS 'max Punkte',
	(SELECT MIN([Punkte]) FROM [dbo].[Highscores]) AS 'min Punkte',
	(SELECT AVG(CAST([Punkte] AS BIGINT)) FROM [dbo].[Highscores]) AS 'avg Punkte',
	[Punkte]
FROM [dbo].[Highscores];

-- Unterabfragen sind auch f�r Ausdr�cke g�ltig
SELECT 
	(SELECT MAX([Punkte]) FROM [dbo].[Highscores]) AS 'max Punkte',
	(SELECT MIN([Punkte]) FROM [dbo].[Highscores]) AS 'min Punkte',
	(SELECT AVG(CAST([Punkte] AS BIGINT)) FROM [dbo].[Highscores]) AS 'avg Punkte',
	[Punkte],
	[Punkte] - (SELECT MAX([Punkte]) FROM [dbo].[Highscores]) AS 'Diff zum Max',
	[Punkte] - (SELECT MIN([Punkte]) FROM [dbo].[Highscores]) AS 'Diff zum Min',
	[Punkte] - (SELECT AVG(CAST([Punkte] AS BIGINT)) FROM [dbo].[Highscores]) AS 'Diff zum Avg'
FROM [dbo].[Highscores];

-- Oder in der TOP-Klausel
SELECT TOP (SELECT COUNT(*) / 2 +  50 FROM [dbo].[Highscores]) *
FROM [dbo].[Highscores];
