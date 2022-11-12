USE  [Master]
GO

CREATE FUNCTION [dbo].[fnResourceGovernorClassifier]()
RETURNS sysname
WITH SCHEMABINDING
AS
BEGIN
	 DECLARE @workloadGroup sysname;

	 SELECT TOP 1 @workloadGroup = [Workloadgroup]
	 FROM [dbo].[ResourceGovernorMembershipClassification] (NOLOCK)
	 WHERE [IsActive] = 1 AND 
		  CAST(GETDATE() AS TIME) BETWEEN [StartTime] AND [EndTime] AND 
		   ([LoginOrGroupname] = SUSER_SNAME() OR IS_SRVROLEMEMBER([LoginOrGroupname]) = 1)
	 ORDER BY [Rank] DESC;

	 RETURN  ISNULL(@workloadGroup, 'default');
END
GO


