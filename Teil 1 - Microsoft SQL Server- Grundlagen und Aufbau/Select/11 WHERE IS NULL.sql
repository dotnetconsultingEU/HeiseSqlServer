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

-- NULL muss besonders behandelt werden.
-- Bei welchen Spielern ist nicht bekannt, seit wann sie Mitglied sind?
SELECT * FROM [dbo].[Spieler]
WHERE MitgliedSeit IS NULL;

-- Bei welchen Spielern ist bekannt seit wann sie Mitglied sind?
SELECT * FROM [dbo].[Spieler]
WHERE MitgliedSeit IS NOT NULL;

SELECT * FROM [dbo].[Spieler]
WHERE NOT MitgliedSeit IS NULL;

-- NULL ist wirklich mit �berhaupt nichts identisch
SELECT * FROM [dbo].[Spieler]
WHERE NOT NULL = NULL;

-- ISNULL-Funktion
SELECT *, ISNULL(MitgliedSeit, GETDATE()) FROM [dbo].[Spieler];

