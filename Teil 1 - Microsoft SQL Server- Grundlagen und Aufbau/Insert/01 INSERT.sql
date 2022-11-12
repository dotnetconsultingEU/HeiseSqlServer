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

-- Eine Zeile einf�gen
INSERT [dbo].[Laender]
(Land) 
VALUES ('Takka-Tukka Land');

-- Test
SELECT * FROM [dbo].[Laender] WHERE [Land] LIKE 'Takka%';

-- Mehrere Zeilen einf�gen
INSERT [dbo].[Laender]
(Land) 
VALUES ('Takka-Tukka Land'),
       ('Lummerland'),
	   ('Sowekistan');

-- Test
SELECT * FROM [dbo].[Laender] 
WHERE [Land] LIKE 'Takka%' OR 
	  [Land] LIKE 'Lum%' OR 
	   [Land] LIKE 'Sowe%'

-- Als Quelle kann auch eine SELECT-Anweisung verwendet werden
-- Anzahl vorher
SELECT COUNT(*) FROM [dbo].[Laender];

INSERT [dbo].[Laender]
(Land) 
SELECT Land FROM [dbo].[Laender];

-- Anzahl nachher
SELECT COUNT(*) FROM [dbo].[Laender];

-- Sind aber Werte ung�ltig kann die Zeile nicht eingef�gt werden
INSERT [dbo].[Spieler]
([Nickname]) VALUES ('Nicky3000')

INSERT [dbo].[Spieler]
([Name], [Nickname]) VALUES (NULL, 'Nicky3000');

-- Die Fehlerm�glichkeiten sind extrem mannigfaltig