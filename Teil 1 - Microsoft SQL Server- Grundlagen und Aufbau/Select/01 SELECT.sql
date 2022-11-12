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

-- Alle Spalten und alle Zeilen der Spieler-Tabelle 
SELECT * FROM [dbo].[Spieler];

-- Die eckigen Klammern können weggelassen werden, wenn der Namen nur Buchstaben und Ziffern enthält
SELECT * FROM dbo.Spieler;

-- 'dbo' ist das Schema in dem sich die Tabelle befindet und kann meistens(!) auch weggelassen werden
SELECT * FROM Spieler;

-- Welche Spalten in welcher Reihenfolge festgelegt werden
SELECT Name, Nickname FROM [dbo].[Spieler];

-- Spalten können für die Ausgabe umbenannt werden mit einem Alias
SELECT Name AS 'Spielername', 
       Nickname AS 'Spitzname'
FROM [dbo].[Spieler];

-- Spaltennamen bei der Ausgabe können auch mehrfach verwendet werden, 
-- das ist aber eher ungewöhnlich und auch recht unpraktisch
SELECT Name AS 'Name', 
       Nickname AS 'Name'
FROM [dbo].[Spieler];
