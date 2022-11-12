USE  [MASTER]
GO

CREATE TABLE [dbo].[ResourceGovernorMembershipClassification](
	[ID] [int] PRIMARY KEY CLUSTERED IDENTITY(1,1) NOT NULL,
	[Rank] [int] NOT NULL CONSTRAINT [DF_ResourceGovernorMembershipClassification_Rank]  DEFAULT ((1)),
	[LoginOrGroupname] [sysname] NULL,
	[StartTime] [time](7) NULL CONSTRAINT [DF_ResourceGovernorMembershipClassification_StartTime]  DEFAULT ('0:00:00'),
	[EndTime] [time](7) NULL CONSTRAINT [DF_ResourceGovernorMembershipClassification_EndTime]  DEFAULT ('23:59:59.999'),
	[Workloadgroup] [nvarchar](128) NOT NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF__ResourceG__IsAct__147C05D0]  DEFAULT ((1)),
) ON [PRIMARY]

GO


