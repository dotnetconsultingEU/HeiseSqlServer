-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Jedoch wird keine Garantie �bernommen, das eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen stehe ich jedoch gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- In Datenbank wechseln
USE dotnetconsulting_TSQL2;
GO

-- Alle gemachten Ums�tze absteigend sortieren und mit
-- dem n�chst niedrigeren Rang vergleichen
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
	[UnR] AS 'Umsatz n�chster Rank',
	[Umsatz] - [UnR] AS 'Delta plus',
	FORMAT(([Umsatz] / [UnR]) - 1, 'P3') AS '% Delta plus'
FROM [cte];
