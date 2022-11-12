-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Es wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen steht der Autor gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

SELECT 
	CONVERT(DECIMAL(18,2), [user_seeks] * [avg_total_user_cost] * ([avg_user_impact] * 0.01)) AS [index_advantage], 
	[migs].[last_user_seek], [mid].[statement] AS [Database.Schema.Table],
	[mid].[equality_columns], [mid].[inequality_columns], [mid].[included_columns],
	[migs].[unique_compiles], [migs].[user_seeks], [migs].[avg_total_user_cost], [migs].[avg_user_impact]
FROM [sys].[dm_db_missing_index_group_stats] AS [migs] WITH (NOLOCK) 
INNER JOIN [sys].[dm_db_missing_index_groups] AS [mig] WITH (NOLOCK) ON [migs].[group_handle] = [mig].[index_group_handle] 
INNER JOIN [sys].[dm_db_missing_index_details] AS [mid] WITH (NOLOCK) ON [mig].[index_handle] = [mid].[index_handle]
WHERE OBJECTPROPERTY([mid].[OBJECT_ID],'IsUserTable') = 1
ORDER BY 1 DESC OPTION (RECOMPILE);
