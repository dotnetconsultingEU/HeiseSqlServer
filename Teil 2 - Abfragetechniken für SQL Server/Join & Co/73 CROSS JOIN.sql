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

-- Anzahl in Tabellen überprüfen
SELECT 
(SELECT COUNT(*) FROM [dbo].[Spieler]) AS '#Spieler',
(SELECT COUNT(*) FROM [dbo].[Videospiele]) AS '#Videospiele'

-- Jedes Spiel wird mit jedem Spieler kombiniert ( = 1.000.000 Zeilen)
SELECT  [vs].[ID] AS 'SpielID',
        [vs].[Name] AS 'SpielName',
		[sp].[Name] AS 'Spieler'
FROM    [dbo].[Videospiele] [vs] CROSS JOIN [dbo].[Spieler] [sp];

