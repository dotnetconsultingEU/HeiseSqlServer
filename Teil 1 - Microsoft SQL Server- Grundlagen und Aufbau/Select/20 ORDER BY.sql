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

-- Ergebnisse können sortiert werden 

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

-- Index der Spalten können verwendet werden, aber das ist nicht
-- besonders übersichtlich bei vielen Spalten
SELECT [Punkte], YEAR([Zeitpunkt]) FROM [dbo].[Highscores] 
ORDER BY 1 DESC, 2 DESC;

-- Es kann nach Ausdrücken/ Spalten sortiert werden die nicht
-- ausgegeben werden
SELECT [Name] FROM [dbo].[Spieler]
ORDER BY YEAR([MitgliedSeit]) DESC; 
