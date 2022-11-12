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

-- Tabelle 
CREATE TABLE [dbo].[Tickets]
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	[Status] VARCHAR(50) NOT NULL,
	TraceID INT NOT NULL
);
GO

-- TableTypes ggf. löschen
IF NOT TYPE_ID('tIDList') IS NULL
	DROP TYPE tIDList;
GO
IF NOT TYPE_ID('tTicketlist') IS NULL
	DROP TYPE tTicketlist;
GO

-- TableTypes anlegen
CREATE TYPE tIDList AS TABLE
(
	ID INT NULL
);
GO

CREATE TYPE tTicketlist AS TABLE
(
	[Status] VARCHAR(50) NOT NULL,
	TraceID INT NOT NULL
);
GO

-- Stored Procedure anlegen
CREATE PROC [dbo].[usp_StoredProcedure_TVP_GetTickets] 
	@IDs tIDList READONLY
AS
BEGIN	
    SELECT  *
    FROM    [dbo].[tickets]
    WHERE   IDENTITYCOL IN (SELECT  ID
                            FROM    @IDs);
END;
GO

-- Stored Procedure anlegen
CREATE PROC [dbo].[usp_StoredProcedure_TVP_DeleteTickets] 
	@IDs tIDList READONLY
AS
BEGIN	
    DELETE  [dbo].[tickets]
    OUTPUT  [deleted].[ID]
    WHERE   IDENTITYCOL IN (SELECT  ID
                            FROM    @IDs);
END;
GO

-- Stored Procedure anlegen
CREATE PROC [dbo].[usp_StoredProcedure_TVP_CreateTickets]
    @tickets tTicketlist READONLY
AS
BEGIN
    INSERT  dbo.Tickets
            ([Status],
             TraceID
            )
    OUTPUT  inserted.IDENTITYCOL
            SELECT  [Status],
                    TraceID
            FROM    @tickets;
END;
GO

-- Testaufrufe
DECLARE @tickets tTicketlist;
INSERT  @tickets
        ([Status], TraceID)
VALUES  ('ut estis quorum Multum in quo, e non quad esset', 22),
        ('ut novum transit. cognitio, in regit, delerium.', 23),
        ('in plorum sed quantare eudis transit. et quo pars', 24),
        ('rarendum vobis transit. travissimantor pladior et', 123),
        ('pladior si non Et si e esset linguens vobis', 112),
        ('homo, non transit. novum nomen in non quantare non', 44);
-- SELECT * FROM @tickets
EXEC [dbo].[usp_StoredProcedure_TVP_CreateTickets] @tickets = @tickets;


DECLARE @list tIDList;
INSERT  @list
        (ID)
VALUES  (1), (2), (5), (999);
EXEC [dbo].[usp_StoredProcedure_TVP_GetTickets] @IDs = @list;
EXEC [dbo].[usp_StoredProcedure_TVP_DeleteTickets] @IDs = @list;