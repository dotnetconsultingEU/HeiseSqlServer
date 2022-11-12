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

-- Eine Sortierung kann  sinnvoll sein um nur 
-- maximal eine bestimmte Anzahl von Zeilen zu liefern
SELECT TOP 10 * FROM [dbo].[Highscores]
ORDER BY [Punkte] DESC;

-- Obwohl TOP auch ohne Sortierung funktioniert
SELECT TOP 10 * FROM [dbo].[Highscores];

SELECT TOP 5 * FROM [dbo].[Highscores]
ORDER BY [Zeitpunkt] ASC;

-- Alle Zeilen, die ebenfalls auf dem letzten Platz sein k�nnten
SELECT TOP 10 * FROM [dbo].[Highscores]
ORDER BY [Zeitpunkt] ASC;

SELECT TOP 5 WITH TIES * FROM [dbo].[Highscores]
ORDER BY YEAR([Zeitpunkt]) DESC;

--  Auch ein Prozentsatz kann angegeben werden
SELECT TOP 10 PERCENT * FROM [dbo].[Highscores]
ORDER BY [Zeitpunkt] ASC;
