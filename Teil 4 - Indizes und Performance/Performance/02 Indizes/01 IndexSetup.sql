-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Es wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen steht der Autor gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank wechseln
USE [dotnetconsulting_Indizes];
GO

-- Heap
-- (Kein Setup notwendig)

-- Heap mit NonclusteredIndex
CREATE NONCLUSTERED INDEX [idx] ON [dbo].[ProduktverzeichnisHeapNonclusteredIndex] ([ID]);

-- Clustered Index
CREATE CLUSTERED INDEX [idx] ON [dbo].[ProduktverzeichnisClusteredIndex] ([ID]);

-- ClusteredColumnstore Index
CREATE CLUSTERED COLUMNSTORE INDEX [idx] ON [dbo].[ProduktverzeichnisClusteredColumnstoreIndex];

-- Zur Kontrolle, es sollten drei Indizes sein
SELECT * FROM [sys].[indexes]
WHERE OBJECT_NAME([OBJECT_ID]) LIKE 'Produktverzeichnis%' AND [name] = 'idx';

-- Aber keine Primary Keys
-- (Außer in der MemoryOptimized-Table, hier muss es einen PK geben)
SELECT * FROM [INFORMATION_SCHEMA].[KEY_COLUMN_USAGE]
WHERE OBJECTPROPERTY(OBJECT_ID([CONSTRAINT_SCHEMA] + '.' + [CONSTRAINT_NAME]), 'IsPrimaryKey') = 1
AND [TABLE_NAME] LIKE 'Produktverzeichnis%';

-- Oder so
SELECT  [i].[name] AS [IndexName],
        OBJECT_NAME([ic].[OBJECT_ID]) AS [TableName],
        COL_NAME([ic].[OBJECT_ID],[ic].[column_id]) AS [ColumnName]
FROM    [sys].[indexes] AS [i] INNER JOIN 
        [sys].[index_columns] AS [ic] ON  [i].[OBJECT_ID] = [ic].[OBJECT_ID]
                                AND [i].[index_id] = [ic].[index_id]
WHERE   [i].[is_primary_key] = 1 AND OBJECT_NAME([ic].[OBJECT_ID]) LIKE 'Produktverzeichnis%';

-- Kleine Übersicht
SELECT OBJECT_NAME([object_id]),* FROM SYS.INDEXES
WHERE OBJECTPROPERTY([OBJECT_ID],'IsUserTable') = 1;