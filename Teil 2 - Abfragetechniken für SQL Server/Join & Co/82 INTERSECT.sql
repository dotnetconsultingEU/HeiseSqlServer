-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Jedoch wird keine Garantie �bernommen, dass eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen stehe ich jedoch gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank wechseln
USE [dotnetconsulting_Videogames]

-- Welche Anfangsbuchstaben sind in Namen der
-- L�nder, Videospiele und Spieler vorhanden

SELECT LEFT([Land], 1) FROM [dbo].[Laender]
INTERSECT
SELECT SUBSTRING([Name], 9, 1) FROM [dbo].[Videospiele]
INTERSECT
SELECT LEFT([Name], 1) FROM [dbo].[Spieler]
ORDER BY 1; -- Sortierung des Ergebnisses