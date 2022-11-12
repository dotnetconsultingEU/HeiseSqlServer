-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank wechseln
USE [dotnetconsulting_Videogames]

-- Welche Anfangsbuchstaben sind in Namen der
-- Länder, Videospiele und Spieler vorhanden

SELECT LEFT([Land], 1) FROM [dbo].[Laender]
INTERSECT
SELECT SUBSTRING([Name], 9, 1) FROM [dbo].[Videospiele]
INTERSECT
SELECT LEFT([Name], 1) FROM [dbo].[Spieler]
ORDER BY 1; -- Sortierung des Ergebnisses