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

-- Nur eindeutige Zeilen zur�ckliefern
SELECT DISTINCT [Name] FROM [dbo].[Spieler];

-- F�r welche Jahre wurden Highscores gespeichert
SELECT DISTINCT YEAR([Zeitpunkt]) FROM [dbo].[Highscores]
ORDER BY YEAR([Zeitpunkt]) DESC;

-- F�r welche Jahre wurden Highscores gespeichert (mit Alias)
SELECT DISTINCT YEAR([Zeitpunkt])  AS 'Jahr'
FROM [dbo].[Highscores]
ORDER BY YEAR([Zeitpunkt]) DESC;

-- F�r welche Jahre wurden Highscores gespeichert (mit Alias & Top)
SELECT DISTINCT TOP 5 YEAR([Zeitpunkt])  AS 'Jahr'
FROM [dbo].[Highscores]
ORDER BY YEAR([Zeitpunkt]) DESC;
