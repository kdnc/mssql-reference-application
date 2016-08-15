-- LIKE Clasues and Index Selectivity

	-- Step 0 - Print some IO and time statistics in Messages tab when running the statement
	SET STATISTICS IO ON
	SET STATISTICS TIME ON



	-- Step 1.1 -	If you use widcard character (%) in front of the value in 
	--				the LIKE clause SQL Server will not be able to use an index for that column
	select *
		from Applicants
		where LastName like '%Harris%'
			and FirstName like '%Thomas%'



	-- Step 2.1 -	If you use widcard character (%) else where in the value of 
	--				the LIKE clause SQL Server will use the index for the characters left to the wildcard
	select *
		from Applicants
		where LastName like 'Harris%'
			and FirstName like 'T%'



	-- Step 3.1 -	If you use widcard character (%) else where in the value of 
	--				the LIKE clause SQL Server will use the index for the characters left to the wildcard.
	--				But in this case, since you only have very few characters before the wildcard, SQL Server
	--				will determine that it is efficient to use scan operation instead of index seek
	--				Compare the Execution Plan with early statements
	select *
		from Applicants
		where LastName like 'Ha%'
			and FirstName like 'T%'