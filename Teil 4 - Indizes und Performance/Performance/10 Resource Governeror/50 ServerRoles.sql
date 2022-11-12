USE [master]
GO
CREATE SERVER ROLE [ResourceGovernorStagingRole];
GO
ALTER SERVER ROLE [ResourceGovernorStagingRole] ADD MEMBER [sqlpoc];
GO