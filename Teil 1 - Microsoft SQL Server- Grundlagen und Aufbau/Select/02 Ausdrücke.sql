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

-- Ausdrücke können Berechnungen durchführen, mit Zeichenketten arbeiten
-- und dabei auch Funktionen verwenden
SELECT [Name] + ' (' + [Nickname] + ')' FROM [dbo].[Spieler];

-- Der einfachste Ausdruck ist jedoch der mit einem konstanten Wert. Dann spielt die Datenbank auch keine Rolle
SELECT 42;

-- Spalten mit Ausdrücken haben ohne Alias keinen Namen
SELECT [Name] + ' (' + [Nickname] + ')' AS 'Name des Spielers' FROM [dbo].[Spieler];

-- Alternativ kann auch eine Funktion zum Einsatz kommen
SELECT CONCAT([Name], ' (', [Nickname], ')') AS 'Name des Spielers' FROM [dbo].[Spieler];

-- String Funktionen
SELECT LEN([Name]) AS 'Länge des Namen',
	   REVERSE([Name]) AS 'Name rückwärts',
	   UPPER([Name]) AS 'Name in GROßBUCHSTABEN',
	   LOWER([Name]) AS 'Name in kleinbuchstaben',
	   LEFT([Name], 2) AS 'Erste beiden Buchstaben',
	   RIGHT([Name], 2) AS 'Letze beiden Buchstaben',
	   SUBSTRING([Name], 2, 2) AS 'Zwei Buchstaben aus dem Namen'
FROM [dbo].[Spieler];

-- Rechnungen mit Zahlen
SELECT Punkte,
	   Punkte + 1000  AS '1000 Punkte mehr'
FROM [dbo].[Highscores];

-- Ausdrücke können auch ohne Bezug zur Tabelle verwendet werden
SELECT GETDATE() AS 'Aktuelles Datum/ Uhrzeit',
	   DATEDIFF(YEAR, '1971-12-18', GETDATE()) AS 'Zeitspanne',
	   @@SERVERNAME AS 'Name des Servers';
	   