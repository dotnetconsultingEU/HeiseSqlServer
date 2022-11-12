-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, das eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- In Datenbank wechseln
USE dotnetconsulting_TSQL2;
GO

-- Alle gemachten Umsätze absteigend sortieren und mit
-- dem nächst niedrigeren Rang vergleichen
;WITH [cte] AS
(
	SELECT TOP 50
		[Name],
		[Umsatz],
		LEAD([Umsatz]) OVER (ORDER BY [Umsatz] DESC) AS 'UnR'
	FROM [dbo].[Vertriebszahlen]
	ORDER BY [Umsatz] DESC
)
SELECT 
	[Name],
	[Umsatz],
	[UnR] AS 'Umsatz nächster Rank',
	[Umsatz] - [UnR] AS 'Delta plus',
	FORMAT(([Umsatz] / [UnR]) - 1, 'P3') AS '% Delta plus'
FROM [cte];
