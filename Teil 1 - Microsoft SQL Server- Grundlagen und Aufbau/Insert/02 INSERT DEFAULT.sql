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

-- Nicht alle Spalten müssen unter Umständen angegeben werden
SELECT ID FROM [dbo].[Laender] WHERE [Land] = 'Germany';

INSERT [dbo].[Spieler]
([HerkunftslandID], [Name], [Nickname])
VALUES (79, 'Teddy', 'Teddy4711');

-- Testausgabe
SELECT * FROM [dbo].[Spieler] WHERE [Nickname] = 'Teddy4711';


-- Oder für die ID des Landes kann auch eine Unterabfrage verwendet werden
INSERT [dbo].[Spieler]
([HerkunftslandID], [Name], [Nickname])
VALUES ((SELECT TOP 1 ID FROM [dbo].[Laender] WHERE [Land] = 'Germany'), 'Teddy', 'Teddy4712');

-- Testausgabe
SELECT * FROM [dbo].[Spieler] WHERE [Nickname] = 'Teddy4712';


-- Oder es kann DEFAULT angegeben werden
INSERT [dbo].[Spieler]
([HerkunftslandID], [Name], [Nickname], [Aktiv], [MitgliedSeit])
VALUES (79, 'Teddy', 'Teddy4713', DEFAULT, DEFAULT);

-- Testausgabe
SELECT * FROM [dbo].[Spieler] WHERE ID = (SELECT MAX(ID) FROM [dbo].[Spieler])


-- Oder alle Spalten mit Werten versehen: auch Funktionen, Unterabfragen und Ausdrücke sind erlaubt
INSERT [dbo].[Spieler]
([HerkunftslandID], [Name], [Nickname], [Aktiv], [MitgliedSeit])
VALUES (79, 'Teddy', 'Teddy4713', 1, GETDATE());

-- Testausgabe (die Zeile sollte den höchsten Wert in der Spalte ID haben)
SELECT * FROM [dbo].[Spieler] WHERE ID = (SELECT MAX(ID) FROM [dbo].[Spieler]);
