-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Es wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen steht der Autor gerne zur Verfügung.
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