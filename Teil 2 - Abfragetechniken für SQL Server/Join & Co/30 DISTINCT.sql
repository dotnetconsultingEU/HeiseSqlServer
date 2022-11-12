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

-- Für welche Jahre wurden Highscores gespeichert
SELECT DISTINCT YEAR([Zeitpunkt]) FROM [dbo].[Highscores]
ORDER BY YEAR([Zeitpunkt]) DESC;

-- Für welche Jahre wurden Highscores gespeichert (mit Alias)
SELECT DISTINCT YEAR([Zeitpunkt])  AS 'Jahr'
FROM [dbo].[Highscores]
ORDER BY YEAR([Zeitpunkt]) DESC;

-- Für welche Jahre wurden Highscores gespeichert (mit Alias & Top)
SELECT DISTINCT TOP 5 YEAR([Zeitpunkt])  AS 'Jahr'
FROM [dbo].[Highscores]
ORDER BY YEAR([Zeitpunkt]) DESC;
