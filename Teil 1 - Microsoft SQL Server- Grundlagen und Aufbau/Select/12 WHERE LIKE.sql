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

-- LIKE erlaubt die Suche in Texten mit Mustern
-- '%' steht für beliebig viele Zeichen
-- '_' steht für ein beliebiges Zeichen
SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE 'A%';

SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE '%man%';

SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE '%i';

SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE 'J__n';

-- '[]' bezeichnen Bereiche
SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE '[A,b,c]%';

SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE '[A-c]%';

SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE '[A-c;k-m]%';
