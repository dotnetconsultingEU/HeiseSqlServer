-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Es wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen steht der Autor gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- In Datenbank wechseln
USE dotnetconsulting_TSQL2;
GO

-- Aufsteigend nummerieren
SELECT ROW_NUMBER() OVER (ORDER BY [ID]), * FROM [dbo].[Vertriebszahlen];

-- Absteigend nummerieren
SELECT ROW_NUMBER() OVER (ORDER BY [ID] DESC), * FROM [dbo].[Vertriebszahlen];

-- Nummerieren, pro Land separat
SELECT ROW_NUMBER() OVER (PARTITION BY [Land] ORDER BY [ID]), * FROM [dbo].[Vertriebszahlen];

-- Beispiel: Erste und letzte Zeile (pro Land) ermitteln, sortiert nach Umsatz
-- Der beste und der schlechteste Verkäufer also
-- Für den Filter wird eine Unterabfrage (oder CTE) benötigt

SELECT 
	[Name],
	CASE WHEN [First] = 1 THEN 'Top' ELSE 'Flop' END 'Bezeichnung',
	FORMAT([Umsatz], 'N2'),
	[Land]
FROM
(
	SELECT ROW_NUMBER() OVER (PARTITION BY [Land] ORDER BY [Umsatz]) AS 'Last',
		   ROW_NUMBER() OVER (PARTITION BY [Land] ORDER BY [Umsatz] DESC) AS 'First',
	* FROM [dbo].[Vertriebszahlen]
) [_] -- Dummy Alias
WHERE [First] = 1 OR [Last] = 1;

-- SQL Server 2022+
SELECT 
	[Name],
	CASE WHEN [First] = 1 THEN 'Top' ELSE 'Flop' END 'Bezeichnung',
	FORMAT([Umsatz], 'N2'),
	[Land]
FROM
(
	SELECT ROW_NUMBER() OVER win AS 'Last',
		   ROW_NUMBER() OVER win AS 'First',
	* FROM [dbo].[Vertriebszahlen]
	WINDOW win AS (PARTITION BY [Land] ORDER BY [Umsatz])

) [_] -- Dummy Alias
WHERE [First] = 1 OR [Last] = 1;