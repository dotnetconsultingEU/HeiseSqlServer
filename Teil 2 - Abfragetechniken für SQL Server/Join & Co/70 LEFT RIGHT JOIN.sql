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
