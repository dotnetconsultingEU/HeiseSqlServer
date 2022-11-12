-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

-- Thorsten Kansy, www.dotnetconsulting.eu

USE master;
GO
DROP DATABASE IF EXISTS [Index];
GO

CREATE DATABASE [Index];
GO
USE [Index];
GO

--DROP TABLE IF EXISTS dbo.Test;
--GO

CREATE TABLE dbo.Test
(
	ID INT PRIMARY KEY,
	Content CHAR(1100)
);
GO

SELECT * from sys.indexes where OBJECT_ID = OBJECT_ID('dbo.test')

INSERT Test (ID, Content) VALUES (10, REPLICATE('a', 1100));
INSERT Test (ID, Content) VALUES (20, REPLICATE('a', 1100));
INSERT Test (ID, Content) VALUES (30, REPLICATE('a', 1100));
INSERT Test (ID, Content) VALUES (40, REPLICATE('a', 1100));
INSERT Test (ID, Content) VALUES (60, REPLICATE('a', 1100));
INSERT Test (ID, Content) VALUES (70, REPLICATE('a', 1100));

BEGIN TRANSACTION;
INSERT Test (ID, Content) VALUES (80, 'b');

SELECT database_transaction_log_bytes_used, '||' '||', * FROM sys.dm_tran_database_transactions where database_id = DB_ID();

COMMIT 
-- ROLLBACK

BEGIN TRANSACTION;
INSERT Test (ID, Content) VALUES (50, 'c');

SELECT database_transaction_log_bytes_used, '||' '||', * FROM sys.dm_tran_database_transactions where database_id = DB_ID();

COMMIT 
-- ROLLBACK
