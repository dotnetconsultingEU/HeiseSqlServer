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

-- Heap
CHECKPOINT; DBCC DROPCLEANBUFFERS; -- Bufferpool (Cache) leeren
SET IDENTITY_INSERT [dbo].[ProduktverzeichnisHeap] ON; -- Identity Wert erhalten
SET STATISTICS TIME ON; -- Zeitmessung an
INSERT [dbo].[ProduktverzeichnisHeap]
(
	   [ID] ,
       [EAN] ,
       [Bezeichnung] ,
       [Beschreibung] ,
       [Preis] ,
       [ProductPage]
)
SELECT * FROM [dbo].[ProduktverzeichnisQuelle];
SET STATISTICS TIME OFF; -- Zeitmessung aus
SET IDENTITY_INSERT [dbo].[ProduktverzeichnisHeap] OFF; -- Identity Wert erhalten

-- Heap mit NonclusteredIndex
CHECKPOINT; DBCC DROPCLEANBUFFERS; -- Bufferpool (Cache) leeren
SET IDENTITY_INSERT [dbo].[ProduktverzeichnisHeapNonclusteredIndex] ON; -- Identity Werte erhalten
SET STATISTICS TIME ON; -- Zeitmessung an
INSERT [dbo].[ProduktverzeichnisHeapNonclusteredIndex]
(
	   [ID] ,
       [EAN] ,
       [Bezeichnung] ,
       [Beschreibung] ,
       [Preis] ,
       [ProductPage]
)
SELECT * FROM [dbo].[ProduktverzeichnisQuelle];
SET STATISTICS TIME OFF; -- Zeitmessung aus
SET IDENTITY_INSERT [dbo].[ProduktverzeichnisHeapNonclusteredIndex] OFF; -- Identity Wert erhalten

-- Clustered Index
CHECKPOINT; DBCC DROPCLEANBUFFERS; -- Bufferpool (Cache) leeren
SET IDENTITY_INSERT [dbo].[ProduktverzeichnisClusteredIndex] ON; -- Identity Werte erhalten
SET STATISTICS TIME ON; -- Zeitmessung an
INSERT [dbo].[ProduktverzeichnisClusteredIndex]
(
	   [ID] ,
       [EAN] ,
       [Bezeichnung] ,
       [Beschreibung] ,
       [Preis] ,
       [ProductPage]
)
SELECT * FROM [dbo].[ProduktverzeichnisQuelle];
SET STATISTICS TIME OFF; -- Zeitmessung aus
SET IDENTITY_INSERT [dbo].[ProduktverzeichnisClusteredIndex] OFF; -- Identity Werte erhalten

-- ClusteredColumnstore Index
CHECKPOINT; DBCC DROPCLEANBUFFERS; -- Bufferpool (Cache) leeren
SET IDENTITY_INSERT [dbo].[ProduktverzeichnisClusteredColumnstoreIndex] ON; -- Identity Werte erhalten
SET STATISTICS TIME ON; -- Zeitmessung an
INSERT [dbo].[ProduktverzeichnisClusteredColumnstoreIndex]
(
	   [ID] ,
       [EAN] ,
       [Bezeichnung] ,
       [Beschreibung] ,
       [Preis] ,
       [ProductPage]
)
SELECT * FROM [dbo].[ProduktverzeichnisQuelle];
SET STATISTICS TIME OFF; -- Zeitmessung aus
SET IDENTITY_INSERT [dbo].[ProduktverzeichnisClusteredColumnstoreIndex] OFF; -- Identity Werte erhalten

-- Memory Optimized Table (Durability: Schema and Data)
CHECKPOINT; DBCC DROPCLEANBUFFERS; -- Bufferpool (Cache) leeren
SET IDENTITY_INSERT [dbo].[ProduktverzeichnisInMemory] ON; -- Identity Werte erhalten
SET STATISTICS TIME ON; -- Zeitmessung an
INSERT [dbo].[ProduktverzeichnisInMemory]
(
	   [ID] ,
       [EAN] ,
       [Bezeichnung] ,
       [Beschreibung] ,
       [Preis] ,
       [ProductPage]
)
SELECT * FROM [dbo].[ProduktverzeichnisQuelle];
SET STATISTICS TIME OFF; -- Zeitmessung aus
SET IDENTITY_INSERT [dbo].[ProduktverzeichnisInMemory] OFF; -- Identity Werte erhalten

-- Memory Optimized Table (Durability: Nur Schema)
CHECKPOINT; DBCC DROPCLEANBUFFERS; -- Bufferpool (Cache) leeren
SET IDENTITY_INSERT [dbo].[ProduktverzeichnisInMemorySchemaOnly] ON; -- Identity Werte erhalten
SET STATISTICS TIME ON; -- Zeitmessung an
INSERT [dbo].[ProduktverzeichnisInMemorySchemaOnly]
(
	   [ID] ,
       [EAN] ,
       [Bezeichnung] ,
       [Beschreibung] ,
       [Preis] ,
       [ProductPage]
)
SELECT * FROM [dbo].[ProduktverzeichnisQuelle];
SET STATISTICS TIME OFF; -- Zeitmessung aus
SET IDENTITY_INSERT [dbo].[ProduktverzeichnisInMemorySchemaOnly] OFF; -- Identity Werte erhalten


-- Alle Daten wieder löschen (bei Bedarf)
TRUNCATE TABLE [dbo].[ProduktverzeichnisHeap];
TRUNCATE TABLE [dbo].[ProduktverzeichnisHeapNonclusteredIndex];
TRUNCATE TABLE [dbo].[ProduktverzeichnisClusteredIndex];
TRUNCATE TABLE [dbo].[ProduktverzeichnisClusteredColumnstoreIndex];
DELETE [dbo].[ProduktverzeichnisInMemory];
DELETE [dbo].[ProduktverzeichnisInMemorySchemaOnly];