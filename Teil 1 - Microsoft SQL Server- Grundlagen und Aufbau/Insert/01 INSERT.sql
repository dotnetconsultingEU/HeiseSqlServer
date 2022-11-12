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

-- Eine Zeile einfügen
INSERT [dbo].[Laender]
(Land) 
VALUES ('Takka-Tukka Land');

-- Test
SELECT * FROM [dbo].[Laender] WHERE [Land] LIKE 'Takka%';

-- Mehrere Zeilen einfügen
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

-- Sind aber Werte ungültig kann die Zeile nicht eingefügt werden
INSERT [dbo].[Spieler]
([Nickname]) VALUES ('Nicky3000')

INSERT [dbo].[Spieler]
([Name], [Nickname]) VALUES (NULL, 'Nicky3000');

-- Die Fehlermöglichkeiten sind extrem mannigfaltig