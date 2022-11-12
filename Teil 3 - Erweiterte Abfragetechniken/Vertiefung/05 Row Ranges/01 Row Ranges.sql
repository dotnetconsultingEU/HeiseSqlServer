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

-- Gleitender Durchschnitt 5 Zeilen vor und nach
SELECT 
	[Name],
	[Umsatz],
	AVG([Umsatz]) OVER (ORDER BY [Umsatz] DESC ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING)
FROM [dbo].[Vertriebszahlen]
ORDER BY [Umsatz] DESC;

-- Durchschnitt über alle Zeilen bis zur aktuellen Zeile und 5 Zeilen danach
SELECT 
	[Name],
	[Umsatz],
	AVG([Umsatz]) OVER (ORDER BY [Umsatz] DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 5 FOLLOWING)
FROM [dbo].[Vertriebszahlen]
ORDER BY [Umsatz] DESC;

-- Maximum über alle Zeilen bis zur aktuellen Zeile
SELECT 
	[Name],
	[Umsatz],
	MAX([Umsatz]) OVER (ORDER BY [Umsatz] DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM [dbo].[Vertriebszahlen]
ORDER BY [Umsatz] DESC;

-- Summe über alle Zeilen faktisch alle Zeilen
SELECT 
	[Name],
	[Umsatz],
	SUM([Umsatz]) OVER (ORDER BY [Umsatz] DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM [dbo].[Vertriebszahlen]
ORDER BY [Umsatz] DESC;
