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

-- Aufsteigend nummerieren
SELECT ROW_NUMBER() OVER (ORDER BY [ID]), * FROM [dbo].[Vertriebszahlen];

-- Absteigend nummerieren
SELECT ROW_NUMBER() OVER (ORDER BY [ID] DESC), * FROM [dbo].[Vertriebszahlen];

-- Nummerieren, pro Land separat
SELECT ROW_NUMBER() OVER (PARTITION BY [Land] ORDER BY [ID]), * FROM [dbo].[Vertriebszahlen];

-- Beispiel: Erste und letzte Zeile (pro Land) ermitteln, sortiert nach Umsatz
-- Der beste und der schlechteste Verk�ufer also
-- F�r den Filter wird eine Unterabfrage (oder CTE) ben�tigt

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