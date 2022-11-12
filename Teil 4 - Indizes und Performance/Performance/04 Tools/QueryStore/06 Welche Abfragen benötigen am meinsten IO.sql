-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Jedoch wird keine Garantie �bernommen, das eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen stehe ich jedoch gerne zur Verf�gung.
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
