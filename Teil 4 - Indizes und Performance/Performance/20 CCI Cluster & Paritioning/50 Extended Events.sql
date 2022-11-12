-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, das eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

USE [master];
GO

-- Anlegen
IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='cci')
    DROP EVENT session [cci] ON SERVER;
CREATE EVENT SESSION [cci] ON SERVER
	ADD EVENT [sqlserver].[columnstore_tuple_mover_begin_compress],
	ADD EVENT [sqlserver].[columnstore_tuple_mover_end_compress],
	-- ADD EVENT sqlserver.clustered_columnstore_index_rebuild, 
	-- ADD EVENT sqlserver.column_store_object_pool_hit, 
	ADD EVENT sqlserver.column_store_object_pool_miss, 
	ADD EVENT sqlserver.column_store_rowgroup_read_issued, 
	ADD EVENT sqlserver.column_store_rowgroup_readahead_issued
	ADD TARGET [package0].[asynchronous_file_target]
 (SET filename = 'c:\temp\cci.xel', metadatafile = 'c:\temp\.xem');

-- Starten
ALTER EVENT SESSION [cci] ON SERVER STATE=START;

-- Auswerten
SELECT * FROM [sys].[fn_xe_file_target_read_file]('c:\temp\*.xel', 'c:\temp\*.xem', NULL, NULL)

-- Auswerten II
WITH    [e]
          AS (SELECT    CAST([event_data] AS XML) AS [x]
              FROM      [sys].[fn_xe_file_target_read_file]('c:\temp\*.xel', 'c:\temp\*.xem', NULL, NULL)
             )
    SELECT  [x].value(N'(//event/@name)[1]', 'varchar(40)') AS [event],
            [x].value(N'(//event/@timestamp)[1]', 'datetime') AS [time]
    FROM    [e]
    ORDER BY [time] DESC;


