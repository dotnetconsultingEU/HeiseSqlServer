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

-- Zeilen k�nnen mit Bedinungen (Pr�dikate) gefiltert werden
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

-- Dies bezieht sich auf den n�chsten Ausdruck oder die Klammer
SELECT * FROM [dbo].[Spieler]
WHERE NOT ([HerkunftslandID] = 45 AND [Aktiv] = 0);

-- Ungleichheit mit '!=' oder '<>' formuliert
SELECT * FROM [dbo].[Spieler]
WHERE [HerkunftslandID] != 100;

-- Gr��er und Kleiner sind auch m�glich. Auch bei Zeichenfolgen und Datum/ Uhrzeit
SELECT * FROM [dbo].[Spieler]
WHERE [Name] > 'F';

SELECT * FROM [dbo].[Highscores]
WHERE [Punkte] < 100000;

SELECT * FROM [dbo].[Highscores]
WHERE [Zeitpunkt] > '20151231'; -- Jahr Monat Tag

SELECT * FROM [dbo].[Highscores]
WHERE [Zeitpunkt] BETWEEN '20150701' AND '20151231'; -- Jahr Monat Tag

-- Nat�rlich k�nnen auch Ausdr�cke verwendet werden
SELECT [Punkte], [Zeitpunkt] FROM [dbo].[Highscores]
WHERE DATEDIFF(DAY, [Zeitpunkt], GETDATE()) < 100;

-- Und auch Unterabfragen
-- Letzte Anmeldung(en)
SELECT * FROM [dbo].[Spieler]
WHERE [MitgliedSeit] = (SELECT MAX([MitgliedSeit]) FROM [dbo].[Spieler])