-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Es wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen steht der Autor gerne zur Verfügung.

USE [dotnetconsulting_PartitionDB];
GO

-- Thorsten Kansy, www.dotnetconsulting.eu
DROP TABLE IF EXISTS dbo.Buchungen;
GO

CREATE TABLE dbo.Buchungen
	(
	ID int NOT NULL  IDENTITY (1, 1),
	Buchungsdatum date NOT NULL,
	Wert1 nchar(10) NULL,
	Wert2 nchar(10) NULL,
	Wert3 nchar(10) NULL
	);
GO
ALTER TABLE dbo.Buchungen ADD CONSTRAINT
	PK_Buchungen PRIMARY KEY CLUSTERED 
	(
	ID,
	Buchungsdatum
	) ON [ArchivierungPerBuchungsdatum](Buchungsdatum);
GO

-- Daten einfügen
INSERT dbo.Buchungen (Buchungsdatum, Wert1) VALUES ('20110202', 'Test1');
INSERT dbo.Buchungen (Buchungsdatum, Wert1) VALUES ('20150202', 'Test2');
INSERT dbo.Buchungen (Buchungsdatum, Wert1) VALUES ('20160202', 'Test3');
INSERT dbo.Buchungen (Buchungsdatum, Wert1) VALUES ('20170202', 'Test4');
INSERT dbo.Buchungen (Buchungsdatum, Wert1) VALUES ('20180202', 'Test5');
INSERT dbo.Buchungen (Buchungsdatum, Wert1) VALUES ('20190202', 'Test6');
INSERT dbo.Buchungen (Buchungsdatum, Wert1) VALUES ('20200202', 'Test7');
INSERT dbo.Buchungen (Buchungsdatum, Wert1) VALUES ('20270202', 'Test8');

-- Partitionen ausgeben
SELECT * FROM sys.partitions WHERE OBJECT_ID = OBJECT_ID('dbo.Buchungen');

-- Welcher Datensatz liegt wo?
SELECT $PARTITION.[fnArchivierungPerBuchungsdatum](Buchungsdatum),* FROM dbo.Buchungen;

-- Partionierte Tabelle ausgeben
SELECT *
FROM sys.tables AS t
    JOIN sys.indexes AS i
        ON t.[object_id] = i.[object_id]
           AND i.[type] IN ( 0, 1 )
    JOIN sys.partition_schemes ps
        ON i.data_space_id = ps.data_space_id
-- WHERE t.object_id = OBJECT_ID('dbo.Buchungen');
GO  