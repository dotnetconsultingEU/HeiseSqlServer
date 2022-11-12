-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Jedoch wird keine Garantie �bernommen, dass eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen stehe ich jedoch gerne zur Verf�gung.

-- Thorsten Kansy, www.dotnetconsulting.eu

-- Welche Indizies gibt es?
SELECT * FROM sys.indexes;

-- Wie oft wurde welcher wie verwendet?
DECLARE @db_id INT = db_ID();
DECLARE @object_id INT = OBJECT_ID(N'Person.Address');

SELECT idx.name, sts.* FROM sys.dm_db_index_usage_stats sts LEFT JOIN sys.indexes idx
ON idx.[object_id] = sts.[object_id] AND idx.index_id = sts.[index_id]
WHERE sts.[object_id] = @object_id AND sts.[database_id] = @db_id;

select * from Person.Address

DBCC FREEPROCCACHE;
GO
-- F�r DB
DECLARE @DBID INT = DB_ID()
DBCC FLUSHPROCINDB(@DBID);
GO

-- E/A Aktivit�t eines Index
DECLARE @db_id INT = db_ID();
DECLARE @object_id INT = OBJECT_ID(N'Person.Address');
DECLARE @index_id INT = NULL;
DECLARE @partition_id INT = NULL;
SELECT * FROM sys.dm_db_index_operational_stats(@db_id, @object_id, @index_id, @partition_id);
GO

-- 
DECLARE @db_id INT = db_ID();
DECLARE @object_id INT = OBJECT_ID(N'Person.Address');
DECLARE @index_id INT = NULL;
DECLARE @partition_id INT = NULL;
SELECT * FROM sys.dm_db_index_physical_stats(@db_id, @object_id, @index_id, @partition_id, 'Limited');
GO
-- Detailed
-- Limited => Keine Auswertung der Leaf Level
-- Sampled => 1% der Leaf Level, wenn Index mehr als 10.000 Pages hat
