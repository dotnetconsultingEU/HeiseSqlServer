-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.

-- Thorsten Kansy, www.dotnetconsulting.eu

-- Beispielinhalt für Demoanwendung 

SET NUMERIC_ROUNDABORT OFF
GO
SET NOCOUNT, XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
/*Pointer used for text / image updates. This might not be needed, but is declared here just in case*/
DECLARE @pv binary(16)
CREATE DATABASE TimeTracking;
GO

BEGIN TRANSACTION

USE TimeTracking;
GO
CREATE SCHEMA [TimeTracking];
GO

CREATE TABLE [TimeTracking].[Customers] (
    [Id] int NOT NULL IDENTITY,
    [IsActive] bit NOT NULL,
    [Displayname] nvarchar(50) NOT NULL,
    [Comment] nvarchar(200) NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [TimeTracking].[Orders] (
    [Id] int NOT NULL IDENTITY,
    [CustomerId] int NULL,
    [OrderNr] nvarchar(50) NOT NULL,
    [Created] date NOT NULL DEFAULT (getdate()),
    CONSTRAINT [PK_Orders] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Orders_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [TimeTracking].[Customers] ([Id]) ON DELETE CASCADE
);

GO

CREATE TABLE [TimeTracking].[Entries] (
    [Id] int NOT NULL IDENTITY,
    [OrderId] int NULL,
    [Start] time NOT NULL,
    [End] time NOT NULL,
    [Break] time NULL DEFAULT '00:00:00',
    [Place] nvarchar(50) NOT NULL,
    [Description] nvarchar(250) NOT NULL,
    [CreatedOrModified] datetime NOT NULL DEFAULT (getdate()),
    CONSTRAINT [PK_Entries] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Entries_Orders_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [TimeTracking].[Orders] ([Id]) ON DELETE CASCADE
);

GO

CREATE INDEX [IX_Entries_OrderId] ON [TimeTracking].[Entries] ([OrderId]);

GO

CREATE INDEX [IX_Orders_CustomerId] ON [TimeTracking].[Orders] ([CustomerId]);

GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TimeTracking].[Orders]') AND [c].[name] = N'OrderNr');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [TimeTracking].[Orders] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [TimeTracking].[Orders] ALTER COLUMN [OrderNr] varchar(50) NOT NULL;

GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TimeTracking].[Entries]') AND [c].[name] = N'Place');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [TimeTracking].[Entries] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [TimeTracking].[Entries] ALTER COLUMN [Place] varchar(50) NOT NULL;

GO

DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TimeTracking].[Entries]') AND [c].[name] = N'Description');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [TimeTracking].[Entries] DROP CONSTRAINT [' + @var2 + '];');
ALTER TABLE [TimeTracking].[Entries] ALTER COLUMN [Description] varchar(250) NOT NULL;

GO

DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TimeTracking].[Customers]') AND [c].[name] = N'Displayname');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [TimeTracking].[Customers] DROP CONSTRAINT [' + @var3 + '];');
ALTER TABLE [TimeTracking].[Customers] ALTER COLUMN [Displayname] varchar(50) NOT NULL;

GO

DECLARE @var4 sysname;
SELECT @var4 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TimeTracking].[Customers]') AND [c].[name] = N'Comment');
IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [TimeTracking].[Customers] DROP CONSTRAINT [' + @var4 + '];');
ALTER TABLE [TimeTracking].[Customers] ALTER COLUMN [Comment] varchar(200) NULL;

GO

ALTER TABLE [TimeTracking].[Orders] ADD [Description] varchar(50) NULL;

GO

DECLARE @var5 sysname;
SELECT @var5 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TimeTracking].[Customers]') AND [c].[name] = N'IsActive');
IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [TimeTracking].[Customers] DROP CONSTRAINT [' + @var5 + '];');
ALTER TABLE [TimeTracking].[Customers] ALTER COLUMN [IsActive] bit NOT NULL;
ALTER TABLE [TimeTracking].[Customers] ADD DEFAULT CAST(1 AS bit) FOR [IsActive];

GO

ALTER TABLE [TimeTracking].[Entries] ADD [Day] datetime2 NOT NULL DEFAULT (getdate());

GO

DROP INDEX [IX_Entries_OrderId] ON [TimeTracking].[Entries];
DECLARE @var6 sysname;
SELECT @var6 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TimeTracking].[Entries]') AND [c].[name] = N'OrderId');
IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [TimeTracking].[Entries] DROP CONSTRAINT [' + @var6 + '];');
ALTER TABLE [TimeTracking].[Entries] ALTER COLUMN [OrderId] int NOT NULL;
CREATE INDEX [IX_Entries_OrderId] ON [TimeTracking].[Entries] ([OrderId]);

GO

DECLARE @var7 sysname;
SELECT @var7 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TimeTracking].[Entries]') AND [c].[name] = N'Day');
IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [TimeTracking].[Entries] DROP CONSTRAINT [' + @var7 + '];');
ALTER TABLE [TimeTracking].[Entries] ALTER COLUMN [Day] date NOT NULL;
ALTER TABLE [TimeTracking].[Entries] ADD DEFAULT (getdate()) FOR [Day];

GO
ALTER TABLE [TimeTracking].[Entries] DROP CONSTRAINT [FK_Entries_Orders_OrderId]
ALTER TABLE [TimeTracking].[Orders] DROP CONSTRAINT [FK_Orders_Customers_CustomerId]
SET IDENTITY_INSERT [TimeTracking].[Orders] ON
INSERT INTO [TimeTracking].[Orders] ([Id], [CustomerId], [OrderNr], [Created], [Description]) VALUES (1, 1, N'Order 1', '20180825', NULL)
INSERT INTO [TimeTracking].[Orders] ([Id], [CustomerId], [OrderNr], [Created], [Description]) VALUES (2, 1, N'Order 2', '20180825', NULL)
INSERT INTO [TimeTracking].[Orders] ([Id], [CustomerId], [OrderNr], [Created], [Description]) VALUES (3, 1, N'Order 3', '20180825', NULL)
INSERT INTO [TimeTracking].[Orders] ([Id], [CustomerId], [OrderNr], [Created], [Description]) VALUES (4, 2, N'Order 4', '20180825', NULL)
SET IDENTITY_INSERT [TimeTracking].[Orders] OFF
SET IDENTITY_INSERT [TimeTracking].[Entries] ON
INSERT INTO [TimeTracking].[Entries] ([Id], [OrderId], [Start], [End], [Break], [Place], [Description], [CreatedOrModified], [Day]) VALUES (1, 1, '09:00:00.0000000', '10:00:00.0000000', '00:00:00.0000000', N'Frankfurt a.M', N'IoC und DI', GETDATE(), GETDATE()-1)
INSERT INTO [TimeTracking].[Entries] ([Id], [OrderId], [Start], [End], [Break], [Place], [Description], [CreatedOrModified], [Day]) VALUES (2, 1, '09:00:00.0000000', '16:00:00.0000000', '00:00:00.0000000', N'Frankfurt a.M.', N'Video aufzeichnen', GETDATE(), GETDATE()-2)
INSERT INTO [TimeTracking].[Entries] ([Id], [OrderId], [Start], [End], [Break], [Place], [Description], [CreatedOrModified], [Day]) VALUES (5, 1, '05:00:00.0000000', '07:00:00.0000000', '00:00:00.0000000', N'Karlsruhe', N'Beschreibung', GETDATE(), GETDATE()-3)
INSERT INTO [TimeTracking].[Entries] ([Id], [OrderId], [Start], [End], [Break], [Place], [Description], [CreatedOrModified], [Day]) VALUES (7, 1, '08:00:00.0000000', '10:00:00.0000000', '00:00:00.0000000', N'Remote', N'Essen gehen', GETDATE(), GETDATE()-4)
INSERT INTO [TimeTracking].[Entries] ([Id], [OrderId], [Start], [End], [Break], [Place], [Description], [CreatedOrModified], [Day]) VALUES (1007, 1, '10:00:00.0000000', '11:00:00.0000000', '00:00:00.0000000', N'Ludwigshafen', N'C# Workshop', GETDATE(), GETDATE()-5)
SET IDENTITY_INSERT [TimeTracking].[Entries] OFF
SET IDENTITY_INSERT [TimeTracking].[Customers] ON
INSERT INTO [TimeTracking].[Customers] ([Id], [IsActive], [Displayname], [Comment]) VALUES (1, 1, N'Customer 1', NULL)
INSERT INTO [TimeTracking].[Customers] ([Id], [IsActive], [Displayname], [Comment]) VALUES (2, 1, N'Customer 2', NULL)
INSERT INTO [TimeTracking].[Customers] ([Id], [IsActive], [Displayname], [Comment]) VALUES (3, 1, N'Customer 3', NULL)
INSERT INTO [TimeTracking].[Customers] ([Id], [IsActive], [Displayname], [Comment]) VALUES (4, 1, N'Customer 4', NULL)
INSERT INTO [TimeTracking].[Customers] ([Id], [IsActive], [Displayname], [Comment]) VALUES (5, 1, N'Customer 5', NULL)
SET IDENTITY_INSERT [TimeTracking].[Customers] OFF
ALTER TABLE [TimeTracking].[Entries]
    ADD CONSTRAINT [FK_Entries_Orders_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [TimeTracking].[Orders] ([Id]) ON DELETE CASCADE
ALTER TABLE [TimeTracking].[Orders]
    ADD CONSTRAINT [FK_Orders_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [TimeTracking].[Customers] ([Id]) ON DELETE CASCADE
COMMIT TRANSACTION

PRINT 'Finished - Fertig';