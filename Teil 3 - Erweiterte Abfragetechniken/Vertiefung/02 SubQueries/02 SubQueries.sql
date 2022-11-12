-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Es wird keine Garantie �bernommen, dass eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen steht der Autor gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- In Datenbank wechseln
USE dotnetconsulting_TSQL2;
GO

SELECT *, -- Spalten wie gew�hnlich ausw�hlen
	-- In Klammern kann die skalare R�ckgabe einer Unterabfrage 
	-- als Spalte verwendet werden
	(SELECT MAX(LEN([name])) FROM [dbo].[Personenverzeichnis]) AS 'Maximale L�nge'
FROM [dbo].[Personenverzeichnis];

SELECT *, -- Spalten wie gew�hnlich ausw�hlen
	-- Die Unterabfrage kann durch die Hauptabfrage eingeschr�nkt werden 
	(SELECT COUNT(*) FROM [dbo].[Personenverzeichnis] WHERE [Name] = [pv].[Name]) AS 'Anzahl des Namens'
FROM [dbo].[Personenverzeichnis] [pv];

-- Damit lassen sich gleiche Namen in der Forma "x von y" durchnummerieren
SELECT *, -- Spalten wie gew�hnlich ausw�hlen
	-- Die Unterabfrage kann durch die Hauptabfrage eingeschr�nkt werden 
	ROW_NUMBER() OVER (PARTITION BY [name] ORDER BY [id]) AS 'Akt Nr',
	(SELECT COUNT(*) FROM [dbo].[Personenverzeichnis] WHERE [Name] = [pv].[Name]) AS 'Anzahl des Namens'
FROM [dbo].[Personenverzeichnis] [pv];

-- Damit lassen sich gleiche Namen in der Form "x von y" durchnummerieren
SELECT 
	CONCAT(ROW_NUMBER() OVER (PARTITION BY [name] ORDER BY [id] ), 
		   ' von ',
	       (SELECT COUNT(*) FROM [dbo].[Personenverzeichnis] WHERE [Name] = [pv].[Name])
		  ) AS 'Nummerierung', 
	[Name],
	IDENTITYCOL
FROM [dbo].[Personenverzeichnis] [pv];