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

-- Tabellenwertausdrücke funktionieren, obwohl oft es auch ein Join täte
-- Gibt es Personen, deren (Nach)name auch ein Vorname ist?
SELECT TOP 10 [pv].*, [inner].[Name], [inner].[Vorname] FROM [dbo].[Personenverzeichnis] [pv]
OUTER APPLY 
(
	-- Hier kann ein kompletter Abfrage-Ausdruck stehen
	SELECT * FROM [dbo].[Personenverzeichnis] WHERE	[Name] = [pv].[Vorname]
	UNION ALL
	SELECT * FROM [dbo].[Personenverzeichnis] WHERE	[Name] = [pv].[Vorname]
) [inner]
WHERE NOT [inner].[Vorname] IS NULL;

-- Besser gleich so
SELECT TOP 10 [pv].*, [inner].[Name], [inner].[Vorname] FROM [dbo].[Personenverzeichnis] [pv]
CROSS APPLY 
(
	-- Hier kann ein kompletter Abfrage-Ausdruck stehen
	SELECT * FROM [dbo].[Personenverzeichnis] WHERE	[Name] = [pv].[Vorname]
	UNION ALL
	SELECT * FROM [dbo].[Personenverzeichnis] WHERE	[Name] = [pv].[Vorname]
) [inner];


GO
-- Tabellenwertfunktion erstellen
CREATE OR ALTER FUNCTION [dbo].[udf_GetPosibleNicknames] 
(
	@Vorname VARCHAR(50)
)
RETURNS 
@result TABLE 
(
	[Rank] INT,
	[Nickname] VARCHAR(50)
)
AS
BEGIN
	IF LEN(@Vorname) > 5
	BEGIN
		DECLARE @counter INT = 0;
		WHILE @counter < 3
			BEGIN
				INSERT @result VALUES (@counter, CONCAT(@Vorname, @counter + 1));
				SET @counter = @counter + 1;
			END
	END	
	RETURN 
END
GO

-- Zwei schnelle Tests
SELECT * FROM [dbo].[udf_GetPosibleNicknames]('Thorsten');
SELECT * FROM [dbo].[udf_GetPosibleNicknames]('Lara');

-- CROSS APPLY
SELECT TOP 10 * FROM [dbo].[Personenverzeichnis] [pv]
CROSS APPLY [dbo].[udf_GetPosibleNicknames]([pv].[Vorname]);

-- OUTER APPLY
SELECT TOP 10 * FROM [dbo].[Personenverzeichnis] [pv]
OUTER APPLY [dbo].[udf_GetPosibleNicknames]([pv].[Vorname]);
