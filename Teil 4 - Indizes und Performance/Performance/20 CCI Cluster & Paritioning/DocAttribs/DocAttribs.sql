-- Disclaimer
-- Dieser Quellcode ist als Vorlage oder als Ideengeber gedacht. Er kann frei und ohne 
-- Auflagen oder Einschränkungen verwendet oder verändert werden.
-- Jedoch wird keine Garantie übernommen, das eine Funktionsfähigkeit mit aktuellen und 
-- zukünftigen API-Versionen besteht. Der Autor übernimmt daher keine direkte oder indirekte 
-- Verantwortung, wenn dieser Code gar nicht oder nur fehlerhaft ausgeführt wird.
-- Für Anregungen und Fragen stehe ich jedoch gerne zur Verfügung.
-- Thorsten Kansy, www.dotnetconsulting.eu

-- Cache leeren
CHECKPOINT;
DBCC DROPCLEANBUFFERS;

-- Was haben wir?
SELECT FORMAT(COUNT(*),'N0') AS '[dbo].[Languages]' FROM [dbo].[Languages];
SELECT FORMAT(COUNT(*),'N0') AS '[dbo].[Attributes]' FROM [dbo].[Attributes];
SELECT FORMAT(COUNT(*),'N0') AS '[dbo].[Documents]' FROM [dbo].[Documents];
SELECT FORMAT(COUNT(*),'N0') AS '[dbo].[AttributesAtDocuments]' FROM [dbo].[AttributesAtDocuments];


-- JOIN über alle Tabellen mit CCI
SELECT * FROM [dbo].[Attributes] attrib 
LEFT JOIN [dbo].[AttributesAtDocuments] aad ON attrib.[ID] = aad.[Attribute]
LEFT JOIN [dbo].[Documents] doc ON aad.[Document] = doc.[ID]
LEFT JOIN [dbo].[Languages] lang ON aad.[Language] = lang.id
WHERE (1=1)
AND lang.[Language] = 'German' 
AND attrib.[Key] = 'Key921'
AND [aad].[AttributeValue] LIKE '%Emg%';

-- Egal welche Reihenfolge die JOINs erfolgen
SELECT * FROM [dbo].[AttributesAtDocuments] aad  
LEFT JOIN [dbo].[Documents] doc ON aad.[Document] = doc.[ID]
LEFT JOIN [dbo].[Attributes] attrib ON attrib.[ID] = aad.[Attribute]
LEFT JOIN [dbo].[Languages] lang ON aad.[Language] = lang.id
WHERE (1=1)
AND lang.[Language] = 'German' 
AND attrib.[Key] = 'Key921'
AND [aad].[AttributeValue] LIKE '%Emg%';

-- Oder so mit 'Vorauswahl' von Sprache und Attribut geht's noch ein wenig schneller
DECLARE @langID INT = (SELECT ID FROM [dbo].[Languages] WHERE [Language] = 'GERMAN');
DECLARE @attrib INT = (SELECT ID FROM [dbo].[Attributes] WHERE [Key] = 'Key921');

SELECT * FROM [dbo].[AttributesAtDocuments] aad LEFT JOIN [dbo].[Attributes] attrib ON attrib.[ID] = aad.[Attribute]
WHERE (1=1)
AND [Attribute] = @attrib
AND [Language] = @langID
AND [aad].[AttributeValue] LIKE '%Emg%';

-- Oder alles in einer Abfrage mit entsprechenden Unterabfragen
SELECT * FROM [dbo].[AttributesAtDocuments] aad LEFT JOIN [dbo].[Attributes] attrib ON attrib.[ID] = aad.[Attribute]
WHERE (1=1)
AND [Attribute] = (SELECT ID FROM [dbo].[Attributes] WHERE [Key] = 'Key921')
AND [Language] = (SELECT ID FROM [dbo].[Languages] WHERE [Language] = 'GERMAN')
AND [aad].[AttributeValue] LIKE '%Emg%';

-- Welche Attribute hat ein bestimmtes Dokument?
SELECT * FROM [dbo].[AttributesAtDocuments] aad LEFT JOIN 
[dbo].[Attributes] attrib ON attrib.[ID] = aad.[Attribute]
WHERE aad.[Document] = 7023456
ORDER BY [attrib].[Key];

CHECKPOINT;
DBCC DROPCLEANBUFFERS;

-- Suche eines Wertes über alle Attribute hinweg, 10 Treffer max
SELECT TOP 10 * FROM [dbo].[AttributesAtDocuments] aad 
INNER JOIN [dbo].[Attributes] attrib ON attrib.[ID] = aad.[Attribute]
INNER JOIN [dbo].[Documents] docs ON aad.[Document] = docs.[ID]
WHERE (1=1)
AND [aad].[Language] = (SELECT ID FROM [dbo].[Languages] WHERE [Language] = 'GERMAN')
AND [aad].[AttributeValue] LIKE '%Emg%';

-- Besser? Ja ;-)
SELECT TOP (10) * FROM 
(
       SELECT aad.*, docs.[Path] FROM
       (
             SELECT [aad].[Document], [aad].[Attribute], [aad].[AttributeValue]  FROM [dbo].[AttributesAtDocuments] aad 
             WHERE [aad].[Language] = (SELECT ID FROM [dbo].[Languages] WHERE [Language] = 'GERMAN')
             AND [aad].[AttributeValue] like 'Emglibicor' -- Emglibicor
       ) aad LEFT JOIN [dbo].[Documents] docs ON [docs].[ID] = [aad].[Document]
) aad LEFT JOIN [dbo].[Attributes] attrib ON attrib.[ID] = aad.[Attribute]
-- OPTION (MAXDOP 8, OPTIMIZE FOR UNKNOWN, querytraceon 9453)



-- BTree
SELECT TOP (10) * FROM 
(
       SELECT aad.*, docs.[Path] FROM
       (
             SELECT [aad].[Document], [aad].[Attribute], [aad].[AttributeValue] FROM [dbo].[AttributesAtDocumentsBTree] aad
             WHERE [aad].[Language] = (SELECT ID FROM [dbo].[Languages] WHERE [Language] = 'GERMAN')
             AND [aad].[AttributeValue] like 'Emglibicor' -- Emglibicor
       ) aad LEFT JOIN [dbo].[DocumentsBTree] docs ON [docs].[ID] = [aad].[Document]
) aad LEFT JOIN [dbo].[Attributes] attrib ON attrib.[ID] = aad.[Attribute];

SELECT COUNT(DISTINCT [AttributeValue]) FROM [dbo].[AttributesAtDocumentsBTree]
-- Wie schaut es unter der Haube aus?
SELECT *, OBJECT_NAME(OBJECT_ID) FROM sys.[column_store_row_groups];



--TRUNCATE TABLE [dbo].[Attributes];
--TRUNCATE TABLE [dbo].[AttributesAtDocuments];
--TRUNCATE TABLE [dbo].[Documents];
--TRUNCATE TABLE [dbo].[Languages];


-- Flache Tabelle aufbauen
SELECT TOP 0 [aad].[ID] AS 'aad.ID'
             ,[attrib].[ID] 'Attrib.ID'
             ,[docs].[ID] AS 'Doc.ID'
             ,[aad].[AttributeValue] 'Attrib.Value'
             ,[attrib].[Key] 'Attrib.Key'
             -- ,[attrib].[Description] 'Attrib.Description'
             ,[docs].[Path] AS 'Doc.Path'
             ,[lang].[ID] AS 'Language.ID'
             -- ,[lang].[Language] 'Language.Language'
INTO dbo.DocumentIndex
FROM [dbo].[AttributesAtDocuments] aad
LEFT JOIN [dbo].[Attributes] attrib ON attrib.id = aad.[Attribute]
LEFT JOIN [dbo].[Documents] docs ON docs.[ID] = aad.[Document]
LEFT JOIN [dbo].[Languages] lang ON [lang].[ID] = [aad].[Language];
GO

-- CCI anlegen
CREATE CLUSTERED COLUMNSTORE INDEX idx ON [dbo].[DocumentIndex];
GO

DECLARE @PageNumber INT = 1;
DECLARE @RowspPage INT = 100000000;

-- Zeilen einfügen
INSERT [dbo].[DocumentIndex]
SELECT TOP (10) [aad].[ID] AS 'aad.ID'
             ,[attrib].[ID] 'Attrib.ID'
             ,[docs].[ID] AS 'Doc.ID'
             ,[aad].[AttributeValue] 'Attrib.Value'
             ,[attrib].[Key] 'Attrib.Key'
             -- ,[attrib].[Description] 'Attrib.Description'
             ,[docs].[Path] AS 'Doc.Path'
             ,[lang].[ID] AS 'Language.ID'
             -- ,[lang].[Language] 'Language.Language'
FROM [dbo].[AttributesAtDocuments] aad
LEFT JOIN [dbo].[Attributes] attrib ON attrib.id = aad.[Attribute]
LEFT JOIN [dbo].[Documents] docs ON docs.[ID] = aad.[Document]
LEFT JOIN [dbo].[Languages] lang ON [lang].[ID] = [aad].[Language]
