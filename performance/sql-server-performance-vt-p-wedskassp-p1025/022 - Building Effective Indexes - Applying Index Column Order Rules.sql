-- Applying Index Column Order Rules

	-- Step 0 - Print some IO and time statistics in Messages tab when running the statement
	SET STATISTICS IO ON
	SET STATISTICS TIME ON

	-- Step 1.1 -	Display the Execution Plan and notice the 'Estimated SubTree Cost' in top SELECT statement
	--				Estimated SubTree Cost - 9.42773
	select *
		from Applicants
		where LastName = 'Davis'
			AND State = 'CO'



	-- Step 2.1 - Create an index on FirstName, LastName and State
	create index IX_Applicants_FirstNameLastName
		on Applicants (FirstName, LastName, State);

	-- Step 2.2 -	Display the Execution Plan and notice the 'Estimated SubTree Cost' in top SELECT statement
	--				Estimated SubTree Cost - 4.35406
	--				Notice the Index is Index Scan operation
	select *
		from Applicants
		where LastName = 'Davis'
			AND State = 'CO'



	-- Step 3.1 - Drop the early created index
	drop index IX_Applicants_FirstNameLastName
		on Applicants;

	-- Step 3.2 -	Recreate a new index, LastName column in first position of the index and FirstName 
	--				column in the second position of the index
	create index IX_Applicants_LastNameFirstName
		on Applicants (LastName, FirstName, State);

	-- Step 3.3 -	Display the Execution Plan and notice the 'Estimated SubTree Cost' in top SELECT statement
	--				Estimated SubTree Cost - 1.40734
	--				Notice the Index has changed to Index Seek operation
	select *
		from Applicants
		where LastName = 'Davis'
			AND State = 'CO'
			 