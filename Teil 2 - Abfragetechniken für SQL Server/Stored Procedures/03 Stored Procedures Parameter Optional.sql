-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, das eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Datenbank (erneut) anlegen und wechseln
:SETVAR dbname dotnetconsulting_StoredProcedures
USE [master];
IF EXISTS (SELECT * FROM [sys].[databases] WHERE [name] = '$(dbname)')
BEGIN
	ALTER DATABASE [$(dbname)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE [$(dbname)];
	PRINT '''$(dbname)''-Datenbank gelöscht';
END
GO
CREATE DATABASE [$(dbname)];
GO
USE [$(dbname)];
PRINT '''$(dbname)''-Datenbank erstellt und gewechselt';
GO

-- Stored Procedure anlegen
CREATE PROCEDURE [dbo].[usp_StoredProcedure_Optional]
    @P1 DATETIME = NULL,
    @P2 INT = 3,
    @P3 VARCHAR(8000) = 'Hello',
    @P4 NVARCHAR(MAX) = N'World',
    @P5 IMAGE
AS
BEGIN
	-- Optionale Werte mit Funktionen 
	IF @P1 IS NULL
		SET @P1 = GETDATE();

    SELECT  @P1 AS 'Parameter1',
            @P2 AS 'Parameter2',
            @P3 AS 'Parameter3',
            @P4 AS 'Parameter4',
            @P5 AS 'Parameter5';
END;
GO

-- Aufrufen
EXEC [dbo].[usp_StoredProcedure_Optional] DEFAULT, DEFAULT, 'Hallo', 'Welt', 0xaffe;

EXEC [dbo].[usp_StoredProcedure_Optional] @P3 = 'Hallo', @P4 = N'Welt', @P5 = 0xaffe;