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

-- Welche Abfragen haben mehere Ausf�hrungspl�ne
WITH    Query_MultPlans
          AS ( SELECT   COUNT(*) AS nrOfPlans ,
                        [QUERY].[query_id]
               FROM     [sys].[query_store_query_text] AS QUERYTEXT
                        INNER JOIN [sys].[query_store_query] AS QUERY ON [QUERYTEXT].[query_text_id] = [QUERY].[query_text_id]
                        INNER JOIN [sys].[query_store_plan] AS QUERYPLAN ON [QUERY].[query_id] = [QUERYPLAN].[query_id]
               GROUP BY [QUERY].[query_id]
               HAVING   COUNT(DISTINCT [QUERYPLAN].[plan_id]) > 1
             )
    SELECT  [QUERY].[query_id] ,
            [QUERYTEXT].[query_sql_text] ,
            [QUERYPLAN].[plan_id] ,
            [QUERYPLAN].[last_compile_start_time] ,
            [QUERYPLAN].[last_execution_time]
    FROM    Query_MultPlans AS qm
            JOIN [sys].[query_store_query] AS QUERY ON [qm].[query_id] = [QUERY].[query_id]
            JOIN [sys].[query_store_plan] AS QUERYPLAN ON [QUERY].[query_id] = [QUERYPLAN].[query_id]
            JOIN [sys].[query_store_query_text] QUERYTEXT ON [QUERYTEXT].[query_text_id] = [QUERY].[query_text_id]
    ORDER BY [QUERYPLAN].[query_id] ,
            [QUERYPLAN].[plan_id];
 
