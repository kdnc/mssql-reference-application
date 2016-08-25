-- Syntax for creating procedure
	-- Method 1 - Keyword PROCEDURE
		CREATE PROCEDURE SchemaName.ProcedureName (
			Parameters (optional)
		)
		AS
			BEGIN
				Do something...
			END;
	
	-- Method 2 - Keyword PROC
		CREATE PROC SchemaName.ProcedureName (
			Parameters (optional)
		)
		AS
			BEGIN
				Do something...
			END;

-- Syntax for executing procedure
	-- Method 1 - Keyword EXECUTE
		EXECUTE SchemaName.ProcedureName

	-- Method 2 - Keyword EXEC
		EXEC SchemaName.ProcedureName


-- Examples
	-- Method 1 - Create a stored procedure using OUTPUT parameter
		create proc dbo.spOutputParamTest
			@contactid int =null,
			@age float OUTPUT
		as
			if @contactid is not null
				begin
					set @age = (select convert(float,(getdate()-dateofbirth))/365.25 from tblcontacts where contactid=@contactid)
				end

		-- Executing spOutputParamTest stored procedure

		declare @thisage float
		execute spOutputParamTest @contactid=46, @age=@thisage output
		print @thisage


	-- Method 2 - Create a stored procedure using RETURN value
		create proc dbo.spReturnValue
			@contactid int =null
		as
			if @contactid is not null
				begin
					declare @countContact int
					set @countContact = (select count(*) from tblcontacts where contactid=@contactid )
					return @countContact
				end

		-- Executing spReturnValue stored procedure

		declare @retval int
		exec @retval = spReturnValue 15
		print @retval


	-- Method 3 - Create a stored procedure to output a record set

		create proc dbo.spOutputRecordset
			@city varchar(50) =null
		as
			if @city is not null
				begin
					select * from tblcontacts where town=@city
				end

		-- Executing spOutputRecordset stored procedure

		execute spOutputRecordset 'leeds'