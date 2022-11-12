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

-- Tabellenwertausdr�cke funktionieren, obwohl oft es auch ein Join t�te
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
