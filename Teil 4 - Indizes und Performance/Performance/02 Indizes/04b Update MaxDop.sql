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

-- Heap mit NonclusteredIndex
SET NOCOUNT ON;

-- Variablen
DECLARE @counter INT = 0,
	    @maxcounter INT = 100000;
DECLARE @ID INT,
        @rowcount INT;

-- Variablen für alle Werte aus der Tabelle (Dummywerte)
DECLARE @dummyID INT;
DECLARE @dummyEAN VARCHAR(14);
DECLARE @dummyBezeichnung VARCHAR(100);
DECLARE @dummyBeschreibung VARCHAR(400);
DECLARE @dummyPreis DECIMAL(18,2);
DECLARE @dummyProductPage VARCHAR(256);

-- Anzahl der Zeilen bestimmen
SELECT @rowcount = COUNT(*) FROM [dbo].[ProduktverzeichnisHeapNonclusteredIndex];
-- Bufferpool (Cache) leeren
CHECKPOINT; DBCC DROPCLEANBUFFERS; 
-- Zeitmessung beginnen
DECLARE @starttime DATETIME = GETDATE(); 

WHILE @counter < @maxcounter
BEGIN
	-- Zufallszahl zwischen 1 und Anzahl Zeilen in der Tabelle
	SET @ID = RAND() * @rowcount;

	-- Änderungen durchführen
	UPDATE [dbo].[ProduktverzeichnisHeapNonclusteredIndex]
		   SET [Preis] = [Preis] * 1.1,
		       [Beschreibung] = 'Neuer Preis'
	WHERE IDENTITYCOL = @ID
	OPTION (MAXDOP 1);

	-- Zwischenstand ausgeben
	SET @counter = @counter + 1;
	IF @counter % 1000 = 0
		PRINT @counter;
END
DECLARE @duration INT = DATEDIFF(ms, @starttime, GETDATE());
PRINT CONCAT(@duration, ' ms (Nonclustered Index)');
GO

-- Clustered Index
SET NOCOUNT ON;

-- Variablen
DECLARE @counter INT = 0,
	    @maxcounter INT = 100000;
DECLARE @ID INT,
        @rowcount INT;

-- Variablen für alle Werte aus der Tabelle (Dummywerte)
DECLARE @dummyID INT;
DECLARE @dummyEAN VARCHAR(14);
DECLARE @dummyBezeichnung VARCHAR(100);
DECLARE @dummyBeschreibung VARCHAR(400);
DECLARE @dummyPreis DECIMAL(18,2);
DECLARE @dummyProductPage VARCHAR(256);

-- Anzahl der Zeilen bestimmen
SELECT @rowcount = COUNT(*) FROM [dbo].[ProduktverzeichnisClusteredIndex];
-- Bufferpool (Cache) leeren
CHECKPOINT; DBCC DROPCLEANBUFFERS; 
-- Zeitmessung beginnen
DECLARE @starttime DATETIME = GETDATE(); 

WHILE @counter < @maxcounter
BEGIN
	-- Zufallszahl zwischen 1 und Anzahl Zeilen in der Tabelle
	SET @ID = RAND() * @rowcount;

	-- Änderungen durchführen
	UPDATE [dbo].[ProduktverzeichnisClusteredIndex]
		   SET [Preis] = [Preis] * 1.1,
		       [Beschreibung] = 'Neuer Preis'
	WHERE IDENTITYCOL = @ID
	OPTION (MAXDOP 1);

	-- Zwischenstand ausgeben
	SET @counter = @counter + 1;
	IF @counter % 1000 = 0
		PRINT @counter;
END
DECLARE @duration INT = DATEDIFF(ms, @starttime, GETDATE());
PRINT CONCAT(@duration, ' ms (Clustered Index)');
GO

-- ClusteredColumnstore Index
SET NOCOUNT ON;

-- Variablen
DECLARE @counter INT = 0,
	    @maxcounter INT = 100000;
DECLARE @ID INT,
        @rowcount INT;

-- Variablen für alle Werte aus der Tabelle (Dummywerte)
DECLARE @dummyID INT;
DECLARE @dummyEAN VARCHAR(14);
DECLARE @dummyBezeichnung VARCHAR(100);
DECLARE @dummyBeschreibung VARCHAR(400);
DECLARE @dummyPreis DECIMAL(18,2);
DECLARE @dummyProductPage VARCHAR(256);

-- Anzahl der Zeilen bestimmen
SELECT @rowcount = COUNT(*) FROM [dbo].[ProduktverzeichnisClusteredColumnstoreIndex];
-- Bufferpool (Cache) leeren
CHECKPOINT; DBCC DROPCLEANBUFFERS; 
-- Zeitmessung beginnen
DECLARE @starttime DATETIME = GETDATE(); 

WHILE @counter < @maxcounter
BEGIN
	-- Zufallszahl zwischen 1 und Anzahl Zeilen in der Tabelle
	SET @ID = RAND() * @rowcount;

	-- Änderungen durchführen
	UPDATE [dbo].[ProduktverzeichnisClusteredColumnstoreIndex]
		   SET [Preis] = [Preis] * 1.1,
		       [Beschreibung] = 'Neuer Preis'
	WHERE IDENTITYCOL = @ID
	OPTION (MAXDOP 1);

	-- Zwischenstand ausgeben
	SET @counter = @counter + 1;
	IF @counter % 1000 = 0
		PRINT @counter;
END
DECLARE @duration INT = DATEDIFF(ms, @starttime, GETDATE());
PRINT CONCAT(@duration, ' ms (Clustered Columnstore)');
GO

-- Memory Optimized
SET NOCOUNT ON;

-- Variablen
DECLARE @counter INT = 0,
	    @maxcounter INT = 100000;
DECLARE @ID INT,
        @rowcount INT;

-- Variablen für alle Werte aus der Tabelle (Dummywerte)
DECLARE @dummyID INT;
DECLARE @dummyEAN VARCHAR(14);
DECLARE @dummyBezeichnung VARCHAR(100);
DECLARE @dummyBeschreibung VARCHAR(400);
DECLARE @dummyPreis DECIMAL(18,2);
DECLARE @dummyProductPage VARCHAR(256);

-- Anzahl der Zeilen bestimmen
SELECT @rowcount = COUNT(*) FROM [dbo].[ProduktverzeichnisInMemory];
-- Bufferpool (Cache) leeren
CHECKPOINT; DBCC DROPCLEANBUFFERS; 
-- Zeitmessung beginnen
DECLARE @starttime DATETIME = GETDATE(); 

WHILE @counter < @maxcounter
BEGIN
	-- Zufallszahl zwischen 1 und Anzahl Zeilen in der Tabelle
	SET @ID = RAND() * @rowcount;

	-- Änderungen durchführen
	UPDATE [dbo].[ProduktverzeichnisInMemory]
		   SET [Preis] = [Preis] * 1.1,
		       [Beschreibung] = 'Neuer Preis'
	WHERE IDENTITYCOL = @ID
	OPTION (MAXDOP 1);

	-- Zwischenstand ausgeben
	SET @counter = @counter + 1;
	IF @counter % 1000 = 0
		PRINT @counter;
END
DECLARE @duration INT = DATEDIFF(ms, @starttime, GETDATE());
PRINT CONCAT(@duration, ' ms (Produktverzeichnis MemoryOptimized)');
GO

-- Memory Optimized (nur Schema)
SET NOCOUNT ON;

-- Variablen
DECLARE @counter INT = 0,
	    @maxcounter INT = 100000;
DECLARE @ID INT,
        @rowcount INT;

-- Variablen für alle Werte aus der Tabelle (Dummywerte)
DECLARE @dummyID INT;
DECLARE @dummyEAN VARCHAR(14);
DECLARE @dummyBezeichnung VARCHAR(100);
DECLARE @dummyBeschreibung VARCHAR(400);
DECLARE @dummyPreis DECIMAL(18,2);
DECLARE @dummyProductPage VARCHAR(256);

-- Anzahl der Zeilen bestimmen
SELECT @rowcount = COUNT(*) FROM [dbo].[ProduktverzeichnisInMemorySchemaOnly];
-- Bufferpool (Cache) leeren
CHECKPOINT; DBCC DROPCLEANBUFFERS; 
-- Zeitmessung beginnen
DECLARE @starttime DATETIME = GETDATE(); 

WHILE @counter < @maxcounter
BEGIN
	-- Zufallszahl zwischen 1 und Anzahl Zeilen in der Tabelle
	SET @ID = RAND() * @rowcount;

	-- Änderungen durchführen
	UPDATE [dbo].[ProduktverzeichnisInMemorySchemaOnly]
		   SET [Preis] = [Preis] * 1.1,
		       [Beschreibung] = 'Neuer Preis'
	WHERE IDENTITYCOL = @ID
	OPTION (MAXDOP 1);

	-- Zwischenstand ausgeben
	SET @counter = @counter + 1;
	IF @counter % 1000 = 0
		PRINT @counter;
END
DECLARE @duration INT = DATEDIFF(ms, @starttime, GETDATE());
PRINT CONCAT(@duration, ' ms (Produktverzeichnis MemoryOptimized, SchemaOnly)');
GO
