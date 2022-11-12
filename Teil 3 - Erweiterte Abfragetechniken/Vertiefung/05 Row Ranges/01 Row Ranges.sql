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

-- Gleitender Durchschnitt 5 Zeilen vor und nach
SELECT 
	[Name],
	[Umsatz],
	AVG([Umsatz]) OVER (ORDER BY [Umsatz] DESC ROWS BETWEEN 5 PRECEDING AND 5 FOLLOWING)
FROM [dbo].[Vertriebszahlen]
ORDER BY [Umsatz] DESC;

-- Durchschnitt �ber alle Zeilen bis zur aktuellen Zeile und 5 Zeilen danach
SELECT 
	[Name],
	[Umsatz],
	AVG([Umsatz]) OVER (ORDER BY [Umsatz] DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 5 FOLLOWING)
FROM [dbo].[Vertriebszahlen]
ORDER BY [Umsatz] DESC;

-- Maximum �ber alle Zeilen bis zur aktuellen Zeile
SELECT 
	[Name],
	[Umsatz],
	MAX([Umsatz]) OVER (ORDER BY [Umsatz] DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM [dbo].[Vertriebszahlen]
ORDER BY [Umsatz] DESC;

-- Summe �ber alle Zeilen faktisch alle Zeilen
SELECT 
	[Name],
	[Umsatz],
	SUM([Umsatz]) OVER (ORDER BY [Umsatz] DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM [dbo].[Vertriebszahlen]
ORDER BY [Umsatz] DESC;
