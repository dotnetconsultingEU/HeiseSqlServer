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

SELECT TOP 25
        [RUNTIMESTATS].[avg_duration] ,
        [QUERYTEXT].[query_sql_text] ,
        [QUERY].[query_id] ,
        [QUERYPLAN].[plan_id] ,
        GETUTCDATE() AS CurrentUTCTime ,
        [RUNTIMESTATS].[last_execution_time]
FROM    [sys].[query_store_query_text] AS QUERYTEXT
        INNER JOIN [sys].[query_store_query] AS QUERY ON [QUERYTEXT].[query_text_id] = [QUERY].[query_text_id]
        INNER JOIN [sys].[query_store_plan] AS QUERYPLAN ON [QUERY].[query_id] = [QUERYPLAN].[query_id]
        INNER JOIN [sys].[query_store_runtime_stats] AS RUNTIMESTATS ON [QUERYPLAN].[plan_id] = [RUNTIMESTATS].[plan_id]
WHERE   [RUNTIMESTATS].[last_execution_time] > DATEADD(HOUR, -1, GETUTCDATE())
ORDER BY [RUNTIMESTATS].[avg_duration] DESC;
 
