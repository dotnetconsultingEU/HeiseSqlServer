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

-- Eine Zeile l�schen
DELETE [dbo].[Spieler]
WHERE [ID] = 3; -- Einschr�nkung ist meistens(!) sinnvoll

-- Test
SELECT * FROM [dbo].[Spieler] WHERE [ID] = 3;


-- Alle Zeilen l�schen
DELETE [dbo].[Spieler];

-- Test. Ups...
SELECT * FROM [dbo].[Spieler];


-- Spieler l�schen, die keinen Highscore haben?
DELETE [dbo].[Spieler]
WHERE NOT ID IN (SELECT [SpielerID] FROM [dbo].[Highscores]);