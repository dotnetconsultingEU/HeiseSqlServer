-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Es wird keine Garantie �bernommen, dass eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen steht der Autor gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Zeit messen
SET STATISTICS TIME ON;

-- IO T�tig messen
SET STATISTICS IO ON;

-- Cache leeren
CHECKPOINT; DBCC DROPCLEANBUFFERS;

SELECT * FROM [dbo].[ProduktverzeichnisHeap] WHERE IDENTITYCOL = 23423;

-- Beides wieder ausschalten
SET STATISTICS TIME, IO OFF;