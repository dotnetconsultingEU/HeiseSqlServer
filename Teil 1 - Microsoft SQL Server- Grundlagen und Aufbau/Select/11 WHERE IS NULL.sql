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

-- NULL muss besonders behandelt werden.
-- Bei welchen Spielern ist nicht bekannt, seit wann sie Mitglied sind?
SELECT * FROM [dbo].[Spieler]
WHERE MitgliedSeit IS NULL;

-- Bei welchen Spielern ist bekannt seit wann sie Mitglied sind?
SELECT * FROM [dbo].[Spieler]
WHERE MitgliedSeit IS NOT NULL;

SELECT * FROM [dbo].[Spieler]
WHERE NOT MitgliedSeit IS NULL;

-- NULL ist wirklich mit überhaupt nichts identisch
SELECT * FROM [dbo].[Spieler]
WHERE NOT NULL = NULL;

-- ISNULL-Funktion
SELECT *, ISNULL(MitgliedSeit, GETDATE()) FROM [dbo].[Spieler];

