WHILE (1=1)
BEGIN
	DECLARE @msg VARCHAR(100), @time VARCHAR(100), @c INT;

	SELECT @c = COUNT(*), @msg = FORMAT(COUNT(*) / 1000000000.00, 'P5'), @time = FORMAT(GETDATE(), 'T') FROM [dbo].[DocumentIndex] (NOLOCK) WHERE [key] IS NULL;
	RAISERROR ('%s %s', 10, 1, @time, @msg) WITH NOWAIT;
	WAITFOR DELAY '0:0:10';
END
