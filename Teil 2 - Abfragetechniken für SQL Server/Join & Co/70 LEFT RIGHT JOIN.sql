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

-- Alle Spiele mit ihren Highscores (wenn es welche gibt)
SELECT  [vs].[ID] AS 'SpielID',
        [vs].[Name] AS 'SpielName',
		[hs].[Punkte] AS 'Punkte'
		-- Die Videospiele stehen links, also "LEFT JOIN"
FROM    [dbo].[Videospiele] [vs] LEFT JOIN [dbo].[Highscores] [hs] ON [vs].[ID] = [hs].[VideospielID];

-- Oder anders herum
SELECT  [vs].[ID] AS 'SpielID',
        [vs].[Name] AS 'SpielName',
		[hs].[Punkte] AS 'Punkte'
		-- Nun stehen die Videospiele rechts, also "RIGHT JOIN"
FROM    [dbo].[Highscores] [hs] RIGHT JOIN [dbo].[Videospiele] [vs] ON [vs].[ID] = [hs].[VideospielID];
