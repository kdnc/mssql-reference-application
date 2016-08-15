-- Interpreting SQL Server Index Recommendations

	-- Step 0 - Print some IO and time statistics in Messages tab when running the statement
	SET STATISTICS IO ON
	SET STATISTICS TIME ON

	

	-- Step 1
	-- * SQL Server Index recommendations can be overly aggressive
	-- * Analyze the recommendation first before creating

	-- Step 1.1 
	-- * Check the Execution Plan
	-- * Notice the Missing Index Recommendation
	SELECT * 
		FROM Students
		WHERE LastName = 'Davis'
			AND State = 'CO'

	-- Step 1.2
	-- * Missing Index Recommendation from above statement
	/*
	Missing Index Details from 028 - Interpreting SQL Server Index Recommendations.sql - (local)\SQLEXPRESS.Students (sa (57))
	The Query Processor estimates that implementing the following index could improve the query cost by 94.8208%.
	*/

	/*
	USE [Students]
	GO
	CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
	ON [dbo].[Students] ([LastName],[State])

	GO
	*/

	-- Step 1.3
	-- * In the above statement SQL Server could use an index which I have created earlier for State.
	-- * SQL Server's recommendations are based on looking at one individual SQL statement
	-- * You want to view these recommendations in the larger context of all of your statements for a given table