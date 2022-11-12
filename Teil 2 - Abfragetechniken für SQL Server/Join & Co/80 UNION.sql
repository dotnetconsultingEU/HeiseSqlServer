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

-- Alle Spieler mit einem bestimmten Anfangsbuchstaben
SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE 'g%'
UNION
-- Alle Spieler die seit 2015 Mitglied sind
SELECT * FROM [dbo].[Spieler] WHERE YEAR([MitgliedSeit]) = 2015;


-- Alle Spieler mit einem bestimmten Anfangsbuchstaben
SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE 'g%'
UNION ALL -- Doppelte sind m�glich (mit bestimmten Anfangsbuchstaben und Mitglied seit 2015)
-- Alle Spieler die seit 2015 Mitglied sind
SELECT * FROM [dbo].[Spieler] WHERE YEAR([MitgliedSeit]) = 2015;


-- Beliebig viele Kombinationen der Mengenoperation sind machbar
SELECT * FROM [dbo].[Spieler] WHERE [Name] LIKE 'g%'
UNION ALL -- Doppelte sind m�glich (mit bestimmten Anfangsbuchstaben und Mitglied seit 2015)
-- Alle Spieler die seit 2015 Mitglied sind
SELECT * FROM [dbo].[Spieler] WHERE YEAR([MitgliedSeit]) = 2015
UNION
-- Alle Spieler die seit 2012 Mitglied sind
SELECT * FROM [dbo].[Spieler] WHERE YEAR([MitgliedSeit]) = 2012;


-- Liste der Namen aller Spiele und Spieler
SELECT 'VS' AS 'Typ', [ID], [Name] FROM [dbo].[Videospiele]
UNION ALL
SELECT 'SP', [ID], [Name] FROM [dbo].[Spieler]


-- Sortierung bezieht sich auf das Gesamtergebnis aus allen Teilmengen
SELECT 'VS' AS 'Typ', [ID], [Name] FROM [dbo].[Videospiele]
UNION ALL
SELECT 'SP', [ID], [Name] FROM [dbo].[Spieler]
WHERE NOT NAME IS NULL
ORDER BY [Name];


-- Filter bezieht sich auf das Gesamtergebnis aus allen Teilmengen,
-- wenn das UNION in einer Unterabfrage steht
SELECT * FROM 
(
	SELECT 'VS' AS 'Typ', [ID], [Name] FROM [dbo].[Videospiele]
	UNION ALL
	SELECT 'SP', [ID], [Name] FROM [dbo].[Spieler]
) T -- Alias zwingend notwendig, auch wenn er nicht verwendet wird!
WHERE NOT NAME IS NULL
ORDER BY [Name];
