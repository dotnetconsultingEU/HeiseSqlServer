-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, das eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Extended Event anlegen
IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='Procs')
    DROP EVENT SESSION [Procs] ON SERVER;
CREATE EVENT SESSION [Procs] ON SERVER
	ADD EVENT sqlserver.sql_statement_recompile(SET collect_object_name=(1),collect_statement=(1)
	ACTION(sqlserver.database_id,sqlserver.database_name,sqlserver.session_id,sqlserver.sql_text,sqlserver.username))
	ADD TARGET [package0].[asynchronous_file_target]
 (SET filename = 'c:\temp\Procs.xel', metadatafile = 'c:\temp\Procs.xem');
 
-- Starten
ALTER EVENT SESSION [Procs] ON SERVER STATE = START;

-- Auswerten
SELECT * FROM [sys].[fn_xe_file_target_read_file]('c:\temp\*.xel', 'c:\temp\*.xem', NULL, NULL);

-- Auswerten II
WITH    [e]
          AS (SELECT    CAST([event_data] AS XML) AS [x]
              FROM      [sys].[fn_xe_file_target_read_file]('c:\temp\*.xel', 'c:\temp\*.xem', NULL, NULL)
             )
    SELECT  [x].value(N'(//event/@name)[1]', 'varchar(40)') AS [event],
            [x].value(N'(//event/@timestamp)[1]', 'datetime') AS [time]
    FROM    [e]
    ORDER BY [time] DESC;