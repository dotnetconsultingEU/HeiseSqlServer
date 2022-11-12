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

-- Zeilen können mit Bedinungen (Prädikate) gefiltert werden
SELECT * FROM [dbo].[Spieler]
WHERE [Name] = 'Alice';

-- Welche Spieler kommen aus dem Land, das die ID 45 hat?
SELECT * FROM [dbo].[Spieler] WHERE [HerkunftslandID] = 45;

-- Welche Spieler sind aktiv?
SELECT * FROM [dbo].[Spieler] WHERE [Aktiv] = 1;

-- Logisch 'Oder' wird mit OR formuliert
SELECT * FROM [dbo].[Spieler]
WHERE [Name] = 'Suzanne' OR [Name] = 'Kirk' OR [Name] = 'Wade';

-- Logisch 'Und' wird mit AND formuliert
SELECT * FROM [dbo].[Spieler]
WHERE [HerkunftslandID] = 45 AND [Aktiv] = 0;

-- Logisch 'Nicht' wird mit NOT formuliert
SELECT * FROM [dbo].[Spieler]
WHERE NOT [HerkunftslandID] = 45 AND [Aktiv] = 0;

-- Dies bezieht sich auf den nächsten Ausdruck oder die Klammer
SELECT * FROM [dbo].[Spieler]
WHERE NOT ([HerkunftslandID] = 45 AND [Aktiv] = 0);

-- Ungleichheit mit '!=' oder '<>' formuliert
SELECT * FROM [dbo].[Spieler]
WHERE [HerkunftslandID] != 100;

-- Größer und Kleiner sind auch möglich. Auch bei Zeichenfolgen und Datum/ Uhrzeit
SELECT * FROM [dbo].[Spieler]
WHERE [Name] > 'F';

SELECT * FROM [dbo].[Highscores]
WHERE [Punkte] < 100000;

SELECT * FROM [dbo].[Highscores]
WHERE [Zeitpunkt] > '20151231'; -- Jahr Monat Tag

SELECT * FROM [dbo].[Highscores]
WHERE [Zeitpunkt] BETWEEN '20150701' AND '20151231'; -- Jahr Monat Tag

-- Natürlich können auch Ausdrücke verwendet werden
SELECT [Punkte], [Zeitpunkt] FROM [dbo].[Highscores]
WHERE DATEDIFF(DAY, [Zeitpunkt], GETDATE()) < 100;

-- Und auch Unterabfragen
-- Letzte Anmeldung(en)
SELECT * FROM [dbo].[Spieler]
WHERE [MitgliedSeit] = (SELECT MAX([MitgliedSeit]) FROM [dbo].[Spieler])