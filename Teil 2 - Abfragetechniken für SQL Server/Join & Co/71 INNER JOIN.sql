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

-- Alle Spiele die zwingend einen Highscore haben
SELECT  [vs].[ID] AS 'SpielID',
        [vs].[Name] AS 'SpielName',
		[hs].[Punkte] AS 'Punkte'
FROM    [dbo].[Videospiele] [vs] INNER JOIN [dbo].[Highscores] [hs] ON [vs].[ID] = [hs].[VideospielID];