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

-- Nicht alle Spalten m�ssen unter Umst�nden angegeben werden
SELECT ID FROM [dbo].[Laender] WHERE [Land] = 'Germany';

INSERT [dbo].[Spieler]
([HerkunftslandID], [Name], [Nickname])
VALUES (79, 'Teddy', 'Teddy4711');

-- Testausgabe
SELECT * FROM [dbo].[Spieler] WHERE [Nickname] = 'Teddy4711';


-- Oder f�r die ID des Landes kann auch eine Unterabfrage verwendet werden
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


-- Oder alle Spalten mit Werten versehen: auch Funktionen, Unterabfragen und Ausdr�cke sind erlaubt
INSERT [dbo].[Spieler]
([HerkunftslandID], [Name], [Nickname], [Aktiv], [MitgliedSeit])
VALUES (79, 'Teddy', 'Teddy4713', 1, GETDATE());

-- Testausgabe (die Zeile sollte den h�chsten Wert in der Spalte ID haben)
SELECT * FROM [dbo].[Spieler] WHERE ID = (SELECT MAX(ID) FROM [dbo].[Spieler]);
