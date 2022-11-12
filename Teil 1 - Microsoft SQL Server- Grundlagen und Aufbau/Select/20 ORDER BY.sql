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

-- Ergebnisse k�nnen sortiert werden 

-- Aufsteigend
SELECT * FROM [dbo].[Highscores] ORDER BY [Punkte];

SELECT * FROM [dbo].[Highscores] ORDER BY [Punkte] ASC;

-- Absteigend
SELECT * FROM [dbo].[Highscores] ORDER BY [Punkte] DESC;

-- Mehrfach sortieren
SELECT [Punkte], YEAR([Zeitpunkt]) FROM [dbo].[Highscores] 
ORDER BY YEAR([Zeitpunkt]), [Punkte];

SELECT [Punkte], YEAR([Zeitpunkt]) FROM [dbo].[Highscores] 
ORDER BY YEAR([Zeitpunkt]) DESC, [Punkte];

SELECT [Punkte], YEAR([Zeitpunkt]) FROM [dbo].[Highscores] 
ORDER BY YEAR([Zeitpunkt]) DESC, [Punkte] DESC;

-- Index der Spalten k�nnen verwendet werden, aber das ist nicht
-- besonders �bersichtlich bei vielen Spalten
SELECT [Punkte], YEAR([Zeitpunkt]) FROM [dbo].[Highscores] 
ORDER BY 1 DESC, 2 DESC;

-- Es kann nach Ausdr�cken/ Spalten sortiert werden die nicht
-- ausgegeben werden
SELECT [Name] FROM [dbo].[Spieler]
ORDER BY YEAR([MitgliedSeit]) DESC; 
