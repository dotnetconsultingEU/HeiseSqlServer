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

-- Alle Spalten und alle Zeilen der Spieler-Tabelle 
SELECT * FROM [dbo].[Spieler];

-- Die eckigen Klammern k�nnen weggelassen werden, wenn der Namen nur Buchstaben und Ziffern enth�lt
SELECT * FROM dbo.Spieler;

-- 'dbo' ist das Schema in dem sich die Tabelle befindet und kann meistens(!) auch weggelassen werden
SELECT * FROM Spieler;

-- Welche Spalten in welcher Reihenfolge festgelegt werden
SELECT Name, Nickname FROM [dbo].[Spieler];

-- Spalten k�nnen f�r die Ausgabe umbenannt werden mit einem Alias
SELECT Name AS 'Spielername', 
       Nickname AS 'Spitzname'
FROM [dbo].[Spieler];

-- Spaltennamen bei der Ausgabe k�nnen auch mehrfach verwendet werden, 
-- das ist aber eher ungew�hnlich und auch recht unpraktisch
SELECT Name AS 'Name', 
       Nickname AS 'Name'
FROM [dbo].[Spieler];
