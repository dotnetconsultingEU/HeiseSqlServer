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

-- Erster Wert
-- Sortiert nach Umsatz
SELECT FIRST_VALUE([Umsatz]) OVER (ORDER BY Umsatz), *
FROM [dbo].[Vertriebszahlen];

-- Sortiert nach Umsatz, pro Land
SELECT FIRST_VALUE([Umsatz]) OVER (PARTITION BY Land ORDER BY Umsatz), *
FROM [dbo].[Vertriebszahlen];


-- Letzter Wert
-- Sortiert nach Umsatz
SELECT LAST_VALUE([Umsatz]) OVER (ORDER BY Umsatz), *
FROM [dbo].[Vertriebszahlen];

-- Sortiert nach Umsatz, pro Land
SELECT LAST_VALUE([Umsatz]) OVER (PARTITION BY Land ORDER BY Umsatz)
FROM [dbo].[Vertriebszahlen];
