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

DECLARE @Start DATETIME = GETDATE();

-- Ranges werden �ber PARTITION BY definiert?
-- Nur bei UNBOUNDED und CURRENT
SELECT 
	[Name],
	[Umsatz],
	AVG([Umsatz]) OVER (PARTITION BY [Land] ORDER BY [Umsatz] DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM [dbo].[Vertriebszahlen]
ORDER BY [Umsatz] DESC;
