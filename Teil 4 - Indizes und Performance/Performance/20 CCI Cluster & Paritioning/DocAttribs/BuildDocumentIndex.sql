USE [dotnetconsulting_DocumentAttributes];
Go

SELECT 
	   [aad].[ID],	   
       [aad].[Language],
       [aad].[Attribute],
       [aad].[Document],
	   [aad].[AttributeValue],
       [attrib].[Key],
       [attrib].[Description],
       [aad].[Path]
INTO dbo.DocumentIndex
FROM 
(
       SELECT [aad].[ID],
              [aad].[Document],
              [aad].[Attribute],
              [aad].[Language],
              [aad].[AttributeValue], docs.[Path] FROM
       (
             SELECT [aad].[ID],
                              [aad].[Document],
                              [aad].[Attribute],
                              [aad].[Language],
                              [aad].[AttributeValue] FROM [dbo].[AttributesAtDocuments] aad
       ) aad LEFT JOIN [dbo].[Documents] docs ON [docs].[ID] = [aad].[Document]
) aad LEFT JOIN [dbo].[Attributes] attrib ON attrib.[ID] = aad.[Attribute];

-- Einfaches SELECT INTO funktioniert auf Grund der Gründe nicht ;-(
SELECT TOP 0 [aad].[ID],
       [aad].[Document],
       [aad].[Attribute],
       [aad].[Language],
       [aad].[AttributeValue] 
INTO [dbo].[DocumentIndex]
FROM [dbo].[AttributesAtDocuments] aad
GO

-- Spalte hinzufügen für Path hinzufügen
ALTER TABLE [dbo].[DocumentIndex] ADD [Path] VARCHAR(256) NULL;
GO

UPDATE di
  SET di.[Path] = docs.[Path]
  FROM [dbo].[DocumentIndex] di
  LEFT JOIN [dbo].[Documents] docs
  ON di.document = docs.id;
GO

-- Spalten für Attribute hinzufügen
ALTER TABLE [dbo].[DocumentIndex] ADD [Key] VARCHAR(50) NULL;
GO
ALTER TABLE [dbo].[DocumentIndex] ADD [Description] VARCHAR(50) NULL;
GO

UPDATE di
  SET di.[key] = attrib.[key], di.[Description] = attrib.[Description]
  FROM [dbo].[DocumentIndex] di
  LEFT JOIN [dbo].[Attributes] attrib
  ON di.Attribute = attrib.id;
GO