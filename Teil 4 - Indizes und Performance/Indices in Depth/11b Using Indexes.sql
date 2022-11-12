-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Jedoch wird keine Garantie  �bernommen, dass eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen stehe ich jedoch gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

--USE <Datenbank>;
GO

SELECT  OBJECT_NAME(A.[object_id]) AS [OBJECT NAME] ,
        I.[name] AS [INDEX NAME] ,
        A.leaf_insert_count ,
        A.leaf_update_count ,
        A.leaf_delete_count,
		'|' '|'
FROM    sys.dm_db_index_operational_stats(NULL, NULL, NULL, NULL) A
        INNER JOIN sys.indexes AS I ON I.[object_id] = A.[object_id]
                                       AND I.index_id = A.index_id
WHERE   OBJECTPROPERTY(A.[object_id], 'IsUserTable') = 1;

SELECT OBJECT_NAME(S.[OBJECT_ID]) AS [OBJECT NAME],
       I.[NAME] AS [INDEX NAME],
       USER_SEEKS,
	   LAST_USER_SEEK,
       USER_SCANS,
       LAST_USER_SCAN,
       USER_LOOKUPS,
	   LAST_USER_LOOKUP,
       USER_UPDATES
	   LAST_USER_UPDATE
FROM SYS.DM_DB_INDEX_USAGE_STATS AS S
    INNER JOIN SYS.INDEXES AS I
        ON I.[OBJECT_ID] = S.[OBJECT_ID]
           AND I.INDEX_ID = S.INDEX_ID
WHERE OBJECTPROPERTY(S.[OBJECT_ID], 'IsUserTable') = 1;