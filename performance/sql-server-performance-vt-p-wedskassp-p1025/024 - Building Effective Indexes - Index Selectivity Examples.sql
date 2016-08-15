-- Index Selectivity Examples

	-- Step 0 - Print some IO and time statistics in Messages tab when running the statement
	SET STATISTICS IO ON
	SET STATISTICS TIME ON



	-- Step 1.1 - Create an index on LastName, FirstName
	create index IX_Students_LastNameFirstName
		on Students (LastName, FirstName);

	-- Step 1.2 -	Display the Execution Plan and notice the Index is Index Seek operation
	select *
		from Students
		where LastName = 'Baker'
			AND FirstName = 'Charles';



	-- Step 2.1 - Create an index on State
	create index IX_Students_State
		on Students (State);

	-- Step 2.2 -	Display the Execution Plan and notice that SQL Server does not infact use the index.
	--				Reason is when SQL Server looks at its statistics, SQL Server gets lot of matches 
	--				for that index.
	--				SQL Server determines if it looks through index and try to match them with the pages,
	--				it gets more expensive and a entire table scan would be efficient.
	--				Notice the 'Estimated SubTree Cost' in top SELECT statement
	--				Estimated SubTree Cost - 2.902
	--				Notice the 'Estimated Number of Rows' in Clustered Index Scan node
	--				Estimated Number of Rows - 19.59
	--				Run the statement and notice 'logical reads' in messages tab
	--				logical reads - 3747
	select *
		from Students
		where State = 'WI'
			AND City = 'Appleton';

	-- Step 2.3 -	If you think, SQL Server makes a mistake by not looking through index, instruct the SQL Server to use the index
	--				But you would be wrong, because almost all of the time SQL Server makes the correct decision.
	--				Display the Execution Plan and notice the 'Estimated SubTree Cost' in top SELECT statement
	--				Estimated SubTree Cost - 5.285
	--				Notice the 'Estimated Number of Rows' in Index Seek and Key lookup nodes
	--				Estimated Number of Rows - 2342	
	--				Run the statement and notice 'logical reads' in messages tab
	--				logical reads - 7189
	--				This turns out to be more expensive than scanning entire table
	--				Reason for this is that the index is not selective enough 
	select *
		from Students with (Index(IX_Students_State))
		where State = 'WI'
			AND City = 'Appleton';

	-- Step 2.4	-	Comparison of above two statement statistics
	--	
	--				Metric				| Chosen by SQL Optimizer	| Index Usage Forced with Hint
	--				------------------------------------------------------------------------------
	--				Data Access Method	| Table Scan				| Index Seek
	--				Statement Cost		| 2.903						| 5.826
	--				Logical Reads		| 3747						| 7189
	


	-- Step 3.1 -	Drop the early created index
	drop index IX_Students_State
		on Students;

	-- Step 3.2 -	Recreate a more selective index, which is over state and city
	create index IX_Students_StateCity
		on Students (State, City);

	-- Step 3.3 -	Measure the statistics for following statement
	select *
		from Students
		where State = 'WI'
			AND City = 'Appleton';

	-- Step 3.4	-	Statment statistics
	--
	--				Metric				| Value	
	--				----------------------------------------------
	--				Data Access Method	| Index Seek			
	--				Statement Cost		| 0.064					
	--				Logical Reads		| 351					