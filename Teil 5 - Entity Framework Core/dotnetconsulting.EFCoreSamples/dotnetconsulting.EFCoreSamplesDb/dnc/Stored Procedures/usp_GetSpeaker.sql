CREATE PROCEDURE dnc.usp_GetSpeaker
	@SearchTerm NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
	SET @SearchTerm = REPLACE(@SearchTerm, '*','%');
	SET @SearchTerm = REPLACE(@SearchTerm, '?','_');

	SELECT TOP 10 [Id], [Homepage], [Infos], [Name], [Created], [IsDeleted], [Updated] FROM [dnc].[Speakers] WHERE 
		(NOT Homepage IS NULL AND Homepage LIKE @SearchTerm) OR
		Infos LIKE @SearchTerm OR 
		(NOT [Name] IS NULL AND [Name] LIKE @SearchTerm);
END
