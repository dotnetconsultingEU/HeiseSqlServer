-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Es wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen steht der Autor gerne zur Verfügung.

-- Thorsten Kansy, www.dotnetconsulting.eu

USE [dotnetconsulting_PartitionDB];
GO

-- Paritionierung nach Jahren, beginnend mit 2016
CREATE PARTITION FUNCTION fnArchivierungPerBuchungsdatum (DATE) AS RANGE 
LEFT -- partition functions use upper boundaries (inclusive)
-- RIGHT -- partition functions use lower boundaries (inclusive)
-- https://littlekendra.com/2017/02/07/understanding-left-vs-right-partition-functions-with-diagrams/
FOR VALUES (
'20161231','20171231','20181231','20191231','20201231',
'20211231','20221231','20231231','20241231','20251231');
GO