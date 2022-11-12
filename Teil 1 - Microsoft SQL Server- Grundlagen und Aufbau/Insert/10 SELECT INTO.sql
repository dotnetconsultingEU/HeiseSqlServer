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


-- Ziel anlegen (darf nicht existieren, Recht muss vorhanden sein) und bef�llen
SELECT [Name], 
	   COUNT(*) AS 'Anzahl'
	   INTO [dbo].[NamenVerteilung]
FROM [dbo].[Spieler]
GROUP BY [Name]
ORDER BY 2 DESC;

-- Test
SELECT * FROM [dbo].[NamenVerteilung];

-- M�glich sind auch tempor�re Tabellen
DROP TABLE IF EXISTS #tmpNamenVerteilung;

SELECT [Name], 
	   COUNT(*) AS 'Anzahl'
	   INTO #tmpNamenVerteilung
FROM [dbo].[Spieler]
GROUP BY [Name]
ORDER BY 2 DESC;

-- Test
SELECT * FROM #tmpNamenVerteilung;