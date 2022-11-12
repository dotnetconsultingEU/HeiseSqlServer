select workloadGroups.Name 'Workload group', session_id, [session].login_name from  sys.dm_exec_sessions [session] left join 
sys.dm_resource_governor_workload_groups workloadGroups ON [session].group_id = workloadGroups.group_id
order by session_id desc;
select [master].[dbo].[fnResourceGovernorClassifier]()


