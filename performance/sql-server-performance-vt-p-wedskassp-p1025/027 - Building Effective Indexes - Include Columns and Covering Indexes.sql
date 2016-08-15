-- Include Columns and Covering Indexes

	-- Step 0 - Print some IO and time statistics in Messages tab when running the statement
	SET STATISTICS IO ON
	SET STATISTICS TIME ON

	

	-- Step 1
	-- * Consider a covering index when you only need to add one or two columns as include columns to give a
	-- performance boost to a key query

	-- Step 1.1 
	-- * Include keyword lets you specify one or more column values should be stored in the index with
	-- the index key, but they are not part of the index key.
	-- * So these include columns cannot be used by the SQL Server to one of the searches to the index.
	-- * They will just have the values stored with the index
	CREATE INDEX IX_STUDENTS_EMAIL
		ON Students (Email)
		INCLUDE (FirstName, LastName);

	-- Step 1.2
	-- * SQL Server is able to find all the data for the query in the index itself
	-- * This avoids needing a key lookup operation to find the data row in the table
	-- * This statement does not use star(*) in the query, instead it returns exactly what columns it wants
	-- * Notice that all the columns are covered in the index
	-- * Check the execution plan
	SELECT Email, FirstName, LastName
		FROM Students
		WHERE email = 'PaulDWilliams@gustr.com';

	-- Step 1.3
	-- * If we have one column that we need we don't have the data for, SQL Server would have to perform
	-- the lookup operation on the table 
	-- * Check the execution plan
	-- * Telephone is needed by the query and since it is not part of the index, the index is not covering 
	-- index for this query, and SQL Server has to go to the table to get that value
	SELECT Email, FirstName, LastName, Telephone
		FROM Students
		WHERE email = 'PaulDWilliams@gustr.com';