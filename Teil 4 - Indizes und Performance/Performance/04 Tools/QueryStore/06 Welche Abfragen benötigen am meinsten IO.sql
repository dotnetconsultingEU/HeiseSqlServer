-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, das eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

USE <DatenbankName, sysname, Datenbank>;
GO

-- Welche Abfragen verursachten die meisten IO-Operationen in den letzten 24 Stunden? 
SELECT TOP 25 
	RUNTIMESTATS.avg_physical_io_reads, 
	QUERYTEXT.query_sql_text,
    QUERY.query_id, 
	QUERYPLAN.plan_id, 
	RUNTIMESTATS.runtime_stats_id,
    RUNTIMESTATSINT.start_time, 
	RUNTIMESTATSINT.end_time, 
	RUNTIMESTATS.avg_rowcount, 
	RUNTIMESTATS.count_executions
 FROM 
	sys.query_store_query_text    AS QUERYTEXT INNER JOIN 
	sys.query_store_query	      AS QUERY        ON QUERYTEXT.query_text_id = QUERY.query_text_id INNER JOIN 
	sys.query_store_plan	      AS QUERYPLAN    ON QUERY.query_id = QUERYPLAN.query_id INNER JOIN 
	sys.query_store_runtime_stats AS RUNTIMESTATS ON QUERYPLAN.plan_id = RUNTIMESTATS.plan_id INNER JOIN 
	sys.query_store_runtime_stats_interval AS RUNTIMESTATSINT ON RUNTIMESTATSINT.runtime_stats_interval_id = RUNTIMESTATS.runtime_stats_interval_id
WHERE RUNTIMESTATSINT.start_time >= DATEADD(hour, -24, GETUTCDATE())
ORDER BY RUNTIMESTATS.avg_physical_io_reads DESC;
