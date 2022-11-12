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

-- Verkäufer sortiert nach Name, mit ihrem jeweiligen Verkaufsrang (Weltweit)
SELECT PERCENT_RANK() OVER (ORDER BY [Umsatz]) AS 'Gesamtrang (%)',
	   * 
FROM [dbo].[Vertriebszahlen]
ORDER BY [Name];

-- Verkäufer sortiert nach Name, mit ihrem jeweiligen Verkaufsrang
-- nun zusätzlich pro Land
SELECT PERCENT_RANK() OVER (ORDER BY [Umsatz]) AS 'Gesamtrang',
	   RANK() OVER (PARTITION BY [Land] ORDER BY [Umsatz]) AS 'Landesrang (%)',
	   * 
FROM [dbo].[Vertriebszahlen]
ORDER BY [Name];

-- Umsatz auf je 1000 (abgerundet)
-- CTE verwenden, um den Ausdruck nur einmal im Code zu haben
;WITH [cte]
AS
(
	SELECT FLOOR([Umsatz] / 1000) * 1000 AS [Umsatz],
		   [Name],
		   [Land]
	FROM [dbo].[Vertriebszahlen] 
)
SELECT PERCENT_RANK() OVER (ORDER BY [Umsatz]) AS 'Gesamtrang (%)',
	   RANK() OVER (PARTITION BY [Land] ORDER BY [Umsatz]) AS 'Landesrang (%)',
	   FORMAT([Umsatz], 'N0'),
	   [Name],
	   [Land]
FROM [cte];

-- SQL Server 2022+
;WITH [cte]
AS
(
	SELECT FLOOR([Umsatz] / 1000) * 1000 AS [Umsatz],
		   [Name],
		   [Land]
	FROM [dbo].[Vertriebszahlen] 
)
SELECT PERCENT_RANK() OVER (ORDER BY [Umsatz]) AS 'Gesamtrang (%)',
	   RANK() OVER win AS 'Landesrang (%)',
	   FORMAT([Umsatz], 'N0'),
	   [Name],
	   [Land]
FROM [cte]
WINDOW win AS (PARTITION BY [Land] ORDER BY [Umsatz]);
