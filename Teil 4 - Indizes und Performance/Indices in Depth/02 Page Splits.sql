-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

-- Thorsten Kansy, www.dotnetconsulting.eu

USE [AdventureWorks2012];

-- Aktuelle Betrachtung der Page splits
Select * from sys.dm_os_performance_counters
where object_name like 'SQLServer:Access Methods%' and counter_name like 'page splits/sec%';

-- Historisch Betrachtung via Transaction Log
Select COUNT(1) AS NumberOfSplits, AllocUnitName , Context
From fn_dblog(NULL,NULL)
Where operation = 'LOP_DELETE_SPLIT'
Group By AllocUnitName, Context
Order by NumberOfSplits desc;

-- Nach Sessions
select * from sys.dm_db_session_space_usage where session_id = @@spid;