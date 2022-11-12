-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Jedoch wird keine Garantie �bernommen, dass eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen stehe ich jedoch gerne zur Verf�gung.

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