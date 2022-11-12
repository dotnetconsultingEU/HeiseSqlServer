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

-- Welche Namen sind doppelt?
SELECT [Name], 
	   COUNT(*) AS 'Anzahl'
FROM [dbo].[Spieler]
GROUP BY [Name]
HAVING COUNT(*) > 1;

-- Es sollen nur die Zeilen ber�cksichtigt werden, in denen der 
-- Name mit einem 'A' beginnt

SELECT [Name], 
	   COUNT(*) AS 'Anzahl'
FROM [dbo].[Spieler]
WHERE [Name] LIKE 'A%'
GROUP BY [Name]
HAVING COUNT(*) > 1;
