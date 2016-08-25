-- Creating an index on a table that has been created

	-- Method 1 
		-- Step 1
		-- Step 1.1 
		-- index is created inline while creating the table.
		CREATE TABLE HumanResources.TerminationReason(
			TerminationReasonID smallint IDENTITY(1,1) NOT NULL,
			TerminationReason varchar(50) NOT NULL,
			DepartmentID smallint NOT NULL INDEX NCI_TerminationReason_DepartmentID NONCLUSTERED,
			CONSTRAINT FK_TerminationReason_DepartmentID FOREIGN KEY (DepartmentID)
			REFERENCES HumanResources.Department(DepartmentID)

	-- Method 2
		-- Step 1
		-- Step 1.1 
		-- define the index so as to be created after the list of columns
		CREATE TABLE HumanResources.TerminationReason(
			TerminationReasonID smallint IDENTITY(1,1) NOT NULL,
			TerminationReason varchar(50) NOT NULL,
			DepartmentID smallint NOT NULL,
			INDEX NCI_TerminationReason_DepartmentID NONCLUSTERED (DepartmentID),
			CONSTRAINT FK_TerminationReason_DepartmentID FOREIGN KEY (DepartmentID)
			REFERENCES HumanResources.Department(DepartmentID)