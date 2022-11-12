/****** Object:  ResourcePool [default]    Script Date: 10.08.2015 14:04:15 ******/
CREATE RESOURCE POOL [stagingResourcePool] WITH(
		min_cpu_percent=0, 
		max_cpu_percent=100, 
		min_memory_percent=0, 
		max_memory_percent=100, 
		cap_cpu_percent=100, 
		AFFINITY SCHEDULER = AUTO, 
		min_iops_per_volume=5, 
		max_iops_per_volume=10);
GO

CREATE WORKLOAD GROUP [stagingWorkloadGroup] WITH(
	    group_max_requests=0, 
		importance=Medium, 
		request_max_cpu_time_sec=0, 
		request_max_memory_grant_percent=25, 
		request_memory_grant_timeout_sec=0,
		max_dop=0) USING [stagingResourcePool];
GO

ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION = [dbo].[fnResourceGovernorClassifier]);
GO

ALTER RESOURCE GOVERNOR RECONFIGURE;
GO
