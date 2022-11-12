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

-- Wieviele Spieler sind in der Datenbank gespeichert?
SELECT COUNT(*) FROM [dbo].[Spieler];

SELECT COUNT(ALL Name) FROM [dbo].[Spieler];

-- Mit Alias
SELECT COUNT(ALL Name) AS 'Spieleranzahl' FROM [dbo].[Spieler];

-- Wieviele unterschiedliche/eindeutige Namen gibt es?
SELECT COUNT(DISTINCT Name) AS 'Spieleranzahl' FROM [dbo].[Spieler];
