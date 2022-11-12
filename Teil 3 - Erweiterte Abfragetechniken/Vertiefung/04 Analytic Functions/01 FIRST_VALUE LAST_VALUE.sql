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
