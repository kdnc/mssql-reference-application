-- Creating an index on a table that has been created

	-- Syntax
		CREATE INDEX IndexName ON TableName (Columns);

		-- Create a clustered index
		CREATE CLUSTERED INDEX IndexName ON TableName (Columns);

		-- Creating non-clustered indexes is very similar:
		CREATE NONCLUSTERED INDEX IndexName ON TableName (Columns);

	-- Example
		CREATE CLUSTERED INDEX IX_C_ContactAddresses_ContactIdPostcode ON 
			dbo.ContactAddresses(ContactId, Postcode)