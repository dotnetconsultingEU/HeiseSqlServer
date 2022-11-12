-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Es wird keine Garantie �bernommen, dass eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen steht der Autor gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- In Datenbank wechseln
USE dotnetconsulting_TSQL2;
GO

-- Temp. Tabelle erstellen und bef�llen
DROP TABLE IF EXISTS #temp;

SELECT * INTO #temp
FROM (
	VALUES 
			(1), (2), (3), (4),
			(5), (6), (7), (8),
			(9), (10), (11), (12),
			(13), (14), (15), (16)
) AS [_]([v])

-- Auf 4 Bl�cke aufteilen, alle sind gleich gro�
SELECT NTILE(4) OVER (ORDER BY [v]), [v]
FROM #temp;

-- Auf 5 Bl�cke aufteilen, gleich gro� k�nnen dann nicht alle sein
SELECT NTILE(5) OVER (ORDER BY [v]), [v]
FROM #temp;

-- Beispiel
-- Werte aus einer Tabelle in n Abschnitt aufteilen und in 
-- aufsteigenden Intervallen darstellen liefern
-- (Auch Bucketing oder Discretizing genannt)

-- Alternative 1
;WITH [cte] AS
(
	SELECT NTILE(5) OVER (ORDER BY [Preis]) AS [Bucket], [Preis] FROM 
	(
		SELECT DISTINCT [PREIS] FROM [dbo].[Produktverzeichnis]
	) [_]
),
[cte2] AS 
(
	SELECT [Bucket], 
		   MIN([Preis]) AS 'Von', 
		   MAX([Preis]) AS 'Bis' 
	FROM [cte]
	GROUP BY [Bucket]
)
SELECT *
	,(SELECT COUNT(*) FROM [dbo].[Produktverzeichnis] WHERE [Preis] BETWEEN [o].[Von] AND [o].[Bis]) AS 'Zeilen im Bucket'
FROM [cte2] [o]
ORDER BY [o].[Bucket];

-- Alternative 2
;WITH [cte2] AS 
(
	SELECT [Bucket], 
		   MIN([Preis]) AS 'Von', 
		   MAX([Preis]) AS 'Bis' 
	FROM 
	(
		SELECT NTILE(5) OVER (ORDER BY [Preis]) AS [Bucket], [Preis] FROM 
		(
			SELECT DISTINCT [PREIS] FROM [dbo].[Produktverzeichnis]
		) [d1]
	) [d2]
	GROUP BY [Bucket]
)
SELECT *
	,(SELECT COUNT(*) FROM [dbo].[Produktverzeichnis] WHERE [Preis] BETWEEN [o].[Von] AND [o].[Bis]) AS 'Zeilen im Bucket'
FROM [cte2] [o]
ORDER BY [o].[Bucket];


-- (Mehr) Performance liefert ein Index
CREATE NONCLUSTERED INDEX [IX_Preis] ON [dbo].[Produktverzeichnis]
( [Preis] ) 
WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

DROP INDEX IF EXISTS [IX_Preis] ON [dbo].[Produktverzeichnis];
GO


-- Kontrolle f�r 5 Buckets
SELECT COUNT(*) FROM [dbo].[Produktverzeichnis]
WHERE [preis] BETWEEN 0 AND 2000.01;
SELECT COUNT(*) FROM [dbo].[Produktverzeichnis]
WHERE [preis] BETWEEN 2000.02 AND 4000.02;
SELECT COUNT(*) FROM [dbo].[Produktverzeichnis]
WHERE [preis] BETWEEN 4000.03 AND 5999.97;
SELECT COUNT(*) FROM [dbo].[Produktverzeichnis]
WHERE [preis] BETWEEN 5999.98 AND 7999.95;
SELECT COUNT(*) FROM [dbo].[Produktverzeichnis]
WHERE [preis] BETWEEN 7999.96 AND 10000.00;

-- Und zusammen ist das...
SELECT 2000323 + 2001238 + 1999594 + 1999398 + 1999447; -- Soll: 10.000.000