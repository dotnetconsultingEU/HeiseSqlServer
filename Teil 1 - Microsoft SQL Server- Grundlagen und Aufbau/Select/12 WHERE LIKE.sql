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

-- LIKE erlaubt die Suche in Texten mit Mustern
-- '%' steht f�r beliebig viele Zeichen
-- '_' steht f�r ein beliebiges Zeichen
SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE 'A%';

SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE '%man%';

SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE '%i';

SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE 'J__n';

-- '[]' bezeichnen Bereiche
SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE '[A,b,c]%';

SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE '[A-c]%';

SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE '[A-c;k-m]%';
