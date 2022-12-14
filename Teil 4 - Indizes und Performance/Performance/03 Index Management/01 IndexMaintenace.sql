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

-- Übersicht, welches Tabelle mit welchem Index existiert
-- ZUsätzlich wird Fragmentierung und Zeilenanzahl angezeigt
SELECT  idx.rows ,
        avg_fragmentation_in_percent ,
        OBJECT_SCHEMA_NAME(t.object_id) ,
        t.name AS 'Table' ,
        idx.name AS 'Index'
FROM    sys.tables t
        CROSS APPLY sys.dm_db_index_physical_stats(DB_ID(), t.object_id, NULL,NULL, NULL)
        LEFT JOIN sys.sysindexes idx ON idx.id = t.object_id
WHERE   OBJECTPROPERTY(t.OBJECT_ID, 'IsUserTable') = 1
        AND idx.indid IN ( 0, 1 )
		AND NOT idx.name IS NULL;

