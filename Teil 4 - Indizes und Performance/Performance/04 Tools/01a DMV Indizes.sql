-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Es wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen steht der Autor gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

SELECT 
	OBJECT_NAME([ius].[object_id]) AS 'TableName', 
	OBJECT_SCHEMA_NAME([ius].[object_id]) AS 'TableSchema', 
	[i].[name] AS 'IndexName',
	[ius].*
FROM [sys].[dm_db_index_usage_stats] [ius] WITH (NOLOCK)
INNER JOIN [SYS].[INDEXES] [i] WITH (NOLOCK) ON [i].[object_id] = [ius].[object_id]
WHERE [ius].[database_id] = DB_ID() AND OBJECTPROPERTY([ius].[OBJECT_ID],'IsUserTable') = 1
ORDER BY 1, 3 OPTION (RECOMPILE);
