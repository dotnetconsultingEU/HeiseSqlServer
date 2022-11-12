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

-- Verk�ufer sortiert nach Name, mit ihrem jeweiligen Verkaufsrang (Weltweit)
SELECT RANK() OVER (ORDER BY [Umsatz]) AS 'Gesamtrang',
	   * 
FROM [dbo].[Vertriebszahlen]
ORDER BY [Name];

-- Verk�ufer sortiert nach Name, mit ihrem jeweiligen Verkaufsrang
-- nun zus�tzlich pro Land
SELECT RANK() OVER (ORDER BY [Umsatz]) AS 'Gesamtrang',
	   RANK() OVER (PARTITION BY [Land] ORDER BY [Umsatz]) AS 'Landesrang',
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
SELECT RANK() OVER (ORDER BY [Umsatz]) AS 'Gesamtrang',
	   RANK() OVER (PARTITION BY [Land] ORDER BY [Umsatz]) AS 'Landesrang',
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
SELECT RANK() OVER win1 AS 'Gesamtrang',
	   RANK() OVER win2 AS 'Landesrang',
	   FORMAT([Umsatz], 'N0'),
	   [Name],
	   [Land]
FROM [cte]
WINDOW win1 AS (ORDER BY [Umsatz]),
	   win2 AS (PARTITION BY [Land] ORDER BY [Umsatz]);