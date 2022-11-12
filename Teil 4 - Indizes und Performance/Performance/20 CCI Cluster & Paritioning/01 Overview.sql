-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr‰nkungen verwendet oder ver‰ndert werden.
-- Jedoch wird keine Garantie ¸bernommen, das eine Funktionsf‰higkeit mit aktuellen und 
-- zuk¸nftigen API-Versionen besteht. Der Autor ¸bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef¸hrt wird.
-- F¸r Anregungen und Fragen stehe ich jedoch gerne zur Verf¸gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Allgemeine Abfragen
SELECT  * FROM    [sys].[column_store_dictionaries]; 
SELECT  * FROM    [sys].[column_store_segments];
SELECT  * FROM    [sys].[column_store_row_groups];

-- Details ¸ber den CCI Store
SELECT  [i].[object_id],
        OBJECT_NAME([i].[object_id]) AS [TableName],
        [i].[name] AS [IndexName],
        [i].[index_id],
        [i].[type_desc],
        [CSRowGroups].*,
        100 * ([total_rows] - ISNULL([deleted_rows], 0)) / [total_rows] AS [PercentFull]
FROM    [sys].[indexes] AS [i]
        JOIN [sys].[column_store_row_groups] AS [CSRowGroups] ON [i].[object_id] = [CSRowGroups].[object_id]
                                                           AND [i].[index_id] = [CSRowGroups].[index_id]
WHERE   OBJECT_NAME([i].[object_id]) = 'AttributesAtDocuments'
ORDER BY OBJECT_NAME([i].[object_id]),
        [i].[name],
        [row_group_id];

-- Ein paar Zeilen lˆschen und ‰ndern
DELETE TOP (10) FROM dbo.AttributesAtDocuments;
UPDATE TOP (10) dbo.AttributesAtDocuments SET [Document] = 99;

-- Index erstellen
CREATE CLUSTERED COLUMNSTORE INDEX CCI ON [dbo].AttributesAtDocuments WITH (DATA_COMPRESSION = COLUMNSTORE);

-- Index neu aufbauen
ALTER INDEX CCI ON [dbo].AttributesAtDocuments REORGANIZE;
ALTER INDEX CCI ON dbo.AttributesAtDocuments REORGANIZE WITH (COMPRESS_ALL_ROW_GROUPS = ON);

ALTER INDEX CCI ON [dbo].AttributesAtDocuments REBUILD;

-- Sperren bei ƒnderungen?
SELECT  [dm_tran_locks].[request_session_id],
        [dm_tran_locks].[resource_database_id],
        DB_NAME([dm_tran_locks].[resource_database_id]) AS [dbname],
        CASE WHEN [resource_type] = 'object' THEN OBJECT_NAME([dm_tran_locks].[resource_associated_entity_id])
             ELSE OBJECT_NAME([partitions].[object_id])
        END AS [ObjectName],
        [partitions].[index_id],
        [indexes].[name] AS [index_name],
        [dm_tran_locks].[resource_type],
        [dm_tran_locks].[resource_description],
        [dm_tran_locks].[resource_associated_entity_id],
        [dm_tran_locks].[request_mode],
        [dm_tran_locks].[request_status]
FROM    [sys].[dm_tran_locks]
        LEFT JOIN [sys].[partitions] ON [partitions].[hobt_id] = [dm_tran_locks].[resource_associated_entity_id]
        JOIN [sys].[indexes] ON [indexes].[object_id] = [partitions].[object_id]
                            AND [indexes].[index_id] = [partitions].[index_id]
WHERE   [resource_associated_entity_id] > 0
        AND [resource_database_id] = DB_ID()
ORDER BY [request_session_id],
        [resource_associated_entity_id]; 

-- Wie groﬂ ist die Tabelle?
exec sp_spaceused 'dbo.AttributesAtDocuments', true;

-- Sppeicherbedarf 
select name, type, pages_kb, pages_in_use_kb, entries_count, entries_in_use_count
	from sys.dm_os_memory_cache_counters 
	where type = 'CACHESTORE_COLUMNSTOREOBJECTPOOL';

-- Trace Flag 634: Keine Komprimierung im Hintergrund
DBCC TRACEON(634,-1);
DBCC TRACEOFF(634);
DBCC TRACESTATUS

-- Reorg des Index
ALTER INDEX CCI ON dbo.AttributesAtDocuments REORGANIZE WITH (COMPRESS_ALL_ROW_GROUPS = ON);

DBCC TRACEOFF(634,-1);



-- Batchmode
option( recompile, querytraceon 9453 );
 
SELECT * FROM dbo.[AttributesAtDocuments] WHERE ID = 925898
option( recompile, querytraceon 9453 );



-- Details
SELECT  *
FROM    [sys].[column_store_segments];
SELECT  DB_ID();

DBCC TRACEON(3604);
DBCC CSIndex (
    25, -- DBID
    72057594041860096, -- HoBT oder PartitionID 
    0, -- column_id 
    0, -- segment_id 
    1, -- 1 (Segment), 2 (Dictionary),
    1 -- {0 or 1 or 2}; No idea what is the difference between those values.
    --[, start]
    --[, end]
);



