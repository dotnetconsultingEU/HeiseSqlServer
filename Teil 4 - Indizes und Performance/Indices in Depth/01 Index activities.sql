-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

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
-- Für DB
DECLARE @DBID INT = DB_ID()
DBCC FLUSHPROCINDB(@DBID);
GO

-- E/A Aktivität eines Index
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
