DROP TABLE IF EXISTS #t;
GO
CREATE TABLE #t
(
	[Ort]	VARCHAR(50) NOT NULL,
	[Name]  VARCHAR(50) NOT NULL
);
GO
INSERT #t
VALUES
    ( 'Dortmund', 'Oliver'),
    ( 'Dortmund', 'Thorsten'),
    ( 'Dortmund', 'Mike'),
    ( 'Nidderau', 'Thorsten'),
    ( 'Nidderau', 'Oliver')
GO

SELECT * FROM #t WHERE Ort = 'Dortmund' AND [Name] = 'Oliver'; -- 1 Treffer
GO
SELECT * FROM #t WHERE Ort = 'Dortmund' AND [Name] = 'Oliver' OR [Name] = 'Thorsten'; -- 3 Treffer
GO
SELECT * FROM #t WHERE Ort = 'Dortmund' AND ([Name] = 'Oliver' OR [Name] = 'Thorsten'); -- 2 Treffer
