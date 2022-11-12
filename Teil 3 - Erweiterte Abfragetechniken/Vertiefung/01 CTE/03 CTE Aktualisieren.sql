-- Disclaimer:
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschr�nkungen verwendet oder ver�ndert werden.
-- Es wird keine Garantie �bernommen, dass eine Funktionsf�higkeit mit aktuellen und 
-- zuk�nftigen API-Versionen besteht. Der Autor �bernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgef�hrt wird.
-- F�r Anregungen und Fragen steht der Autor gerne zur Verf�gung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Eine CTE kann (Rechte und Abfrage entsprechend) aktualisert werden
-- Daf�r darf keine der Spalten konstant oder berechnet sein

-- In Datenbank wechseln
USE dotnetconsulting_TSQL2;
GO

-- Kommentar-Spalte zur�cksetzen und tempor�re Tabelle l�schen
UPDATE [dbo].[Personenverzeichnis] SET [Kommentar] = NULL;
DROP TABLE IF EXISTS #temp;

-- Eine Spalte ist konstant oder berechnet
-- Daher funktioniert diese Abfrage nicht ;-(
WITH [cte]
AS
(
	-- Anker der Rekursion
	SELECT *, 0 AS [Level] FROM [dbo].[Personenverzeichnis] WHERE [VorgesetzerID] IS NULL

	UNION ALL

	-- Rekursion
	SELECT [pv].*, [cte].[Level] + 1 FROM [dbo].[Personenverzeichnis] [pv] INNER JOIN [cte]
	ON [cte].[ID] = [pv].[VorgesetzerID]
)
UPDATE [cte] SET [Kommentar] = CONCAT('Hierarchiestufe: ', [Level]);

-- Mit Hilfe einer tempor�ren Tabelle geht's jedoch
WITH [cte]
AS
(
	-- Anker der Rekursion
	SELECT *, 0 AS [Level] FROM [dbo].[Personenverzeichnis] WHERE [VorgesetzerID] IS NULL

	UNION ALL

	-- Rekursion
	SELECT [pv].*, [cte].[Level] + 1 FROM [dbo].[Personenverzeichnis] [pv] INNER JOIN [cte]
	ON [cte].[ID] = [pv].[VorgesetzerID]
) 
SELECT [ID], [Level] INTO [#temp] FROM [cte]
OPTION (MAXRECURSION 50); -- 100 ist der Standard


-- Jetzt kann die CTE aktualisiert werden!
WITH [cte]
AS
(
	SELECT pv.Kommentar, t.[Level] FROM [dbo].[Personenverzeichnis] [pv]
	INNER JOIN [#temp] [t] ON [t].[ID] = [pv].[ID]
)
UPDATE [cte] SET Kommentar = CONCAT('Hierarchiestufe: ', [Level]);

-- Test 
SELECT * FROM [dbo].[Personenverzeichnis];