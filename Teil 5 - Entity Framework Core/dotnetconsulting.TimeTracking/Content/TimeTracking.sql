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
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
/*Pointer used for text / image updates. This might not be needed, but is declared here just in case*/
DECLARE @pv binary(16)
BEGIN TRANSACTION
ALTER TABLE [TimeTracking].[Entries] DROP CONSTRAINT [FK_Entries_Orders_OrderId]
ALTER TABLE [TimeTracking].[Orders] DROP CONSTRAINT [FK_Orders_Customers_CustomerId]
SET IDENTITY_INSERT [TimeTracking].[Orders] ON
INSERT INTO [TimeTracking].[Orders] ([Id], [CustomerId], [OrderNr], [Created], [Description]) VALUES (1, 1, N'Order 1', '20180825', NULL)
INSERT INTO [TimeTracking].[Orders] ([Id], [CustomerId], [OrderNr], [Created], [Description]) VALUES (2, 1, N'Order 2', '20180825', NULL)
INSERT INTO [TimeTracking].[Orders] ([Id], [CustomerId], [OrderNr], [Created], [Description]) VALUES (3, 1, N'Order 3', '20180825', NULL)
INSERT INTO [TimeTracking].[Orders] ([Id], [CustomerId], [OrderNr], [Created], [Description]) VALUES (4, 2, N'Order 4', '20180825', NULL)
SET IDENTITY_INSERT [TimeTracking].[Orders] OFF
SET IDENTITY_INSERT [TimeTracking].[Entries] ON
INSERT INTO [TimeTracking].[Entries] ([Id], [OrderId], [Start], [End], [Break], [Place], [Description], [CreatedOrModified], [Day]) VALUES (1, 1, '09:00:00.0000000', '10:00:00.0000000', '00:00:00.0000000', N'Frankfurt a.M', N'IoC und DI', GETDATE(), GETDATE())
INSERT INTO [TimeTracking].[Entries] ([Id], [OrderId], [Start], [End], [Break], [Place], [Description], [CreatedOrModified], [Day]) VALUES (2, 1, '09:00:00.0000000', '16:00:00.0000000', '00:00:00.0000000', N'Frankfurt a.M.', N'Video aufzeichnen', GETDATE(), GETDATE())
INSERT INTO [TimeTracking].[Entries] ([Id], [OrderId], [Start], [End], [Break], [Place], [Description], [CreatedOrModified], [Day]) VALUES (5, 1, '05:00:00.0000000', '07:00:00.0000000', '00:00:00.0000000', N'Karlsruhe', N'Beschreibung', GETDATE(), GETDATE())
INSERT INTO [TimeTracking].[Entries] ([Id], [OrderId], [Start], [End], [Break], [Place], [Description], [CreatedOrModified], [Day]) VALUES (7, 1, '08:00:00.0000000', '10:00:00.0000000', '00:00:00.0000000', N'Remote', N'Essen gehen', GETDATE(), GETDATE())
INSERT INTO [TimeTracking].[Entries] ([Id], [OrderId], [Start], [End], [Break], [Place], [Description], [CreatedOrModified], [Day]) VALUES (1007, 1, '10:00:00.0000000', '11:00:00.0000000', '00:00:00.0000000', N'Ludwigshafen', N'C# Workshop', GETDATE(), GETDATE())
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
