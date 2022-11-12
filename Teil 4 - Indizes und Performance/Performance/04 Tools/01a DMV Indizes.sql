-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Es wird keine Garantie �bernommen, dass eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen steht der Autor gerne zur Verf�gung.
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
