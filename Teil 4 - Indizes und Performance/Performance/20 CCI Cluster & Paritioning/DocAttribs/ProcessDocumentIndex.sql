
SET NOCOUNT OFF;
DECLARE @r INT = 1;

GOTO start;

WHILE @r > 0
BEGIN
	Start:

	DECLARE @max INT = 10000000;
	PRINT CONCAT('Start ', GETDATE());
	UPDATE TOP (@max) di
	  SET di.[key] = attrib.[key], di.[Description] = attrib.[Description]
	  FROM [dbo].[DocumentIndex] di
	  LEFT JOIN [dbo].[Attributes] attrib
	  ON di.Attribute = attrib.id
	WHERE di.[key] IS NULL;

	SET @r = @@ROWCOUNT;

	PRINT CONCAT('Fertig ', GETDATE());
END
PRINT CONCAT('Ganz Fertig ', GETDATE());


