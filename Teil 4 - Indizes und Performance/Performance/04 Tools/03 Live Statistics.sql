-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Es wird keine Garantie �bernommen, dass eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen steht der Autor gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank wechseln
USE [AdventureWorks];

-- Via Trace Flag einschalten
DBCC TRACEON(7412,-1);
DBCC TRACESTATUS();

-- Test Abfragen
SELECT * FROM [sys].[objects] o1 CROSS JOIN
[sys].[objects] o2 CROSS JOIN
[sys].[objects] o3 CROSS JOIN
[sys].[objects] o4;