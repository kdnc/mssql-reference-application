-- How Functions in the WHERE Clause Affect Indexes

	-- Step 0 - Print some IO and time statistics in Messages tab when running the statement
	SET STATISTICS IO ON
	SET STATISTICS TIME ON



	-- Step 1.1 
	create index IX_APPLICANTS_EMAIL
		on Applicants (Email);

	-- Step 1.2
	-- * If you have a function on the left side or column side in your where clause, SQL Server 
	-- will not be able to use an index on the table.
	-- * Look at the Execution Plan.
	-- * SQL Server will use a scan operation.
	select * 
		from Applicants
		where SUBSTRING(email, 0, CHARINDEX('@', email, 0)) = 'LouiseJSmith';



	-- Step 2
	-- * How to utilize 'execution plan index seek' when you need to use a function in the where clause

	-- Step 2.1
	-- * Create a column to store the computed value of the function
	alter table Applicants add EmailLocalPart as substring(email, 0, charindex('@', email, 0));

	-- Step 2.2
	-- * Notice that computed values are stored in EmailLocalPart column
	SELECT TOP 100 *
		FROM Applicants;

	-- Step 2.3
	-- * When we run this index create statement, SQL Server is going to compute all the values of this computed
	-- column of each row of the table, and it is going to store the computed values in the index.
	CREATE INDEX IX_APPLICANTS_EMAIL_LOCALPART
		ON Applicants (EmailLocalPart);

	-- Step 2.4
	-- * Look at the Execution Plan.
	-- * SQL Server will use index seek operation this time.
	select * 
		from Applicants
		where SUBSTRING(email, 0, CHARINDEX('@', email, 0)) = 'LouiseJSmith';