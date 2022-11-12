-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Es wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen steht der Autor gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Zeit messen
SET STATISTICS TIME ON;

-- IO Tätig messen
SET STATISTICS IO ON;

-- Cache leeren
CHECKPOINT; DBCC DROPCLEANBUFFERS;

SELECT * FROM [dbo].[ProduktverzeichnisHeap] WHERE IDENTITYCOL = 23423;

-- Beides wieder ausschalten
SET STATISTICS TIME, IO OFF;