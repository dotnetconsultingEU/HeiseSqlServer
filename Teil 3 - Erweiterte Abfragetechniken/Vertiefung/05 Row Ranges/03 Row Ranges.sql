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

DECLARE @Start DATETIME = GETDATE();

-- Ranges werden über PARTITION BY definiert?
-- Nur bei UNBOUNDED und CURRENT
SELECT 
	[Name],
	[Umsatz],
	AVG([Umsatz]) OVER (PARTITION BY [Land] ORDER BY [Umsatz] DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM [dbo].[Vertriebszahlen]
ORDER BY [Umsatz] DESC;
