-- Getting SQL Server's Recommendations on Missing Indexes

	-- Step 1 
	-- * http://buildingbettersoftware.blogspot.com/2016/04/analyzing-index-usage-in-sql-server.html

	-- Step 1.1 
	-- * Finding Missing Indexes
	SELECT     
		TableName = d.statement,
		d.equality_columns, 
		d.inequality_columns,
		d.included_columns, 
		s.user_scans,
		s.user_seeks,
		s.avg_total_user_cost,
		s.avg_user_impact,
		AverageCostSavings = ROUND(s.avg_total_user_cost * (s.avg_user_impact/100.0), 3),
		TotalCostSavings = ROUND(s.avg_total_user_cost * (s.avg_user_impact/100.0) * (s.user_seeks + s.user_scans),3)
	FROM sys.dm_db_missing_index_groups g
	INNER JOIN sys.dm_db_missing_index_group_stats s
		ON s.group_handle = g.index_group_handle
	INNER JOIN sys.dm_db_missing_index_details d
		ON d.index_handle = g.index_handle
	WHERE d.database_id = db_id()
	ORDER BY TableName, TotalCostSavings DESC;
