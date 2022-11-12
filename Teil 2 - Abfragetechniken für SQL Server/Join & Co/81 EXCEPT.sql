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

-- Welche Buchstaben sind nicht am Anfang eines Spielernamens zu finden?
-- Ab SQL Server 2016: STRING_SPLIT('A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z',',')
SELECT 'A' AS 'Nicht vorhanden'
UNION
SELECT 'B'
UNION
SELECT 'C'
UNION
SELECT 'D'
UNION
SELECT 'E'
UNION
SELECT 'F'
UNION
SELECT 'G'
UNION
SELECT 'H'
UNION
SELECT 'I'
UNION
SELECT 'J'
UNION
SELECT 'K'
UNION
SELECT 'L'
UNION
SELECT 'M'
UNION
SELECT 'N'
UNION
SELECT 'O'
UNION
SELECT 'P'
UNION
SELECT 'Q'
UNION
SELECT 'R'
UNION
SELECT 'S'
UNION
SELECT 'T'
UNION
SELECT 'U'
UNION
SELECT 'V'
UNION
SELECT 'W'
UNION
SELECT 'X'
UNION
SELECT 'Y'
UNION
SELECT 'Z'
EXCEPT 
SELECT DISTINCT LEFT([Name],1) FROM [dbo].[Spieler]
ORDER BY 1; -- Sortierung nach 1. Spalte


-- Probe: Spieler mit 'X', 'Y' oder 'Q' am Anfang des Names? Passt!
SELECT * FROM [dbo].[Spieler] WHERE NAME LIKE 'X%' OR NAME LIKE 'Y%' OR NAME LIKE 'Q%';

-- Probe: Spieler mit 'U' am Anfang des Names? Passt!
SELECT * FROM [dbo].[Spieler] WHERE NAME LIKE 'U%'; 