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
GO

-- Tabelle erzeugen
DROP TABLE IF EXISTS [dbo].[SpielerOhnePK]
CREATE TABLE [dbo].[SpielerOhnePK](
	[HerkunftslandID] [int] NULL,
	[Name] [varchar](50) NOT NULL,
	[Nickname] [varchar](50) NOT NULL,
	[Aktiv] [bit] NOT NULL,
	[MitgliedSeit] [date] NULL,
);
GO

-- Mehrere völlig identische Zeilen einfügen 
INSERT [dbo].[SpielerOhnePK] VALUES (73, 'Lot', 'Lottchen', 1, '2018-08-01');
GO 2
INSERT [dbo].[SpielerOhnePK] VALUES (1, 'Harry', 'Harry2', 1, '2018-08-01');
GO 2
INSERT [dbo].[SpielerOhnePK] VALUES (2, 'Ben', 'Hur', 1, '2018-01-01');
GO 1

SELECT * FROM [dbo].[SpielerOhnePK];

-- Alle bis auf eine Zeile löschen
DELETE TOP (SELECT COUNT(*)-1 FROM [dbo].[SpielerOhnePK]) FROM [dbo].[SpielerOhnePK]

-- Alle Dubletten löschen, die exisiteren
DELETE [dbo].[SpielerOhnePK]
WHERE %%lockres%% in 
(
	SELECT [$key] FROM 
	(
		SELECT *,
				ROW_NUMBER() over(PARTITION BY [HerkunftslandID], [Name], [Nickname], [Aktiv], [MitgliedSeit] -- Welche Spalten beschreiben die Dublette? 
								  ORDER BY %%lockres%% -- Beliebige(!) Sortierung
								 ) AS RowNr,
				%%lockres%% AS [$key]
		FROM [dbo].[SpielerOhnePK]
	) _
	WHERE RowNr != 1 -- Alle bis außer der erste Zeile
);