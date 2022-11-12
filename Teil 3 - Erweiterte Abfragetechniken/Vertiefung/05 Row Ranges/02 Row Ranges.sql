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

;WITH [cte]
AS
(
	SELECT
		-- CTE auch daher sinnvoll, weil ROW_NUMBER nicht direkt in SUM() verwendet werden kann
		ROW_NUMBER() OVER (ORDER BY [ID]) AS 'StartionsNr',
		[Station],
		[FahrtzeitInMinuten]
	FROM [dbo].[Fahrtzeiten]
)
SELECT 
	*,
	FORMAT(
	-- Fahrtzeit
	DATEADD(mi,
		-- Aufsummierte Fahrtzeit seit Start 
		SUM([FahrtzeitInMinuten]) OVER (ORDER BY [StartionsNr] ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) - [FahrtzeitInMinuten] 
		-- Fünf Minuten Haltezeit
		+ ([StartionsNr] - 1) * 5, 
		@Start),
	-- Datum/ Uhrzeit formatieren	
	'dd/MM/yyyy hh:mm')
	 AS 'Abfahrt'
FROM [cte]
ORDER BY [StartionsNr];


