-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Es wird keine Garantie übernommen, dass eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen steht der Autor gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Komplexe Abfragen können mit CTEs in einfachere Abfragen zerteilt werden
-- Dadurch das einzelne CTEs auch einzelt ausgeführt werden können, ist auch
-- die Entwicklung und der Test einfacher

-- In Datenbank wechseln
USE dotnetconsulting_TSQL2;
GO

-- Die erste CTE erzeugt einen vollständigen Name
WITH [cte1] AS
(
	SELECT [ID], CONCAT([Vorname], [Name]) AS [Fullname] FROM [dbo].[Personenverzeichnis]
),

-- Die zwei CTE kann auf die erste CTE zugreifen und bestimmt
-- die Länge des Namens
[cte2] AS
(
	SELECT [ID], LEN([Fullname]) AS [NameLength] FROM [cte1]	
),

-- Die dritte CTE kann auf CTE 1 + 2 zugreifen und sucht die
-- maximale Länge des vollständigen Name
[cte3] AS
(
	SELECT MAX([NameLength]) AS [MaxLength] FROM [cte2]
),

-- Die vierte CTE kann auf CTE 1 - 3 zugreifen und stellt
-- alle für das Endergebnis zusammen
[cte4] AS
(
	SELECT [pv].[id],
		[cte1].[Fullname],
		CAST([cte2].[NameLength] AS DECIMAL) AS [NameLength],
		(SELECT [MaxLength] FROM [cte3]) AS [MaxLength]	
	FROM [dbo].[Personenverzeichnis] [pv]
	LEFT JOIN [cte1] ON [pv].[ID] = [cte1].[ID]
	LEFT JOIN [cte2] ON [pv].[ID] = [cte2].[ID]
),

-- Die vierte CTE kann auf CTE 1 - 4 zugreifen und
-- führte die letzte Berechnung durch in dem die Länge
-- prozentual zur maximale Länge berechnet wird
[cteFinal] AS
(
	SELECT *,
		[NameLength] / [MaxLength] AS [PercentLength]
	FROM [cte4]
)

-- Zum Schluss eine Abfrage, die alle vorherigen CTEs zugreifen
-- kann
SELECT FORMAT([PercentLength],'P'), * FROM [cteFinal]
ORDER BY [PercentLength] DESC;

-- Bei der nächsten Abfragen stehen die CTEs nicht mehr zur Vergügung.
-- Diese Abfrage führt daher schlicht zu einem Fehler
SELECT * FROM [cte3];