-- CURSOR SYNTAX

-- declare variables for use in cursors
declare @whatever varchar(100)

--declare your cursor 
DECLARE MY_cursor CURSOR
  for select contactid from tblcontacts
OPEN MY_cursor
FETCH NEXT FROM MY_cursor 
INTO --variables defined above. One for each column of the select statement 


WHILE @@FETCH_STATUS = 0
begin

--do some work

FETCH NEXT FROM MY_cursor
INTO --variables defined above
end
CLOSE MY_cursor
   DEALLOCATE MY_cursor
   



-- Example of CURSOR

-- declare variables for use in cursors
declare @id int, @dob smalldatetime
declare @totalValue float, @age int

create table #tblResults(
	clientid int null,
	salesvalue float null,
	age int null)


--declare your cursor 
DECLARE MY_cursor CURSOR
  for select contactid, dateofbirth from tblcontacts 
OPEN MY_cursor
FETCH NEXT FROM MY_cursor 
INTO @id, @dob
--variables defined above. One for each column of the select statement 


WHILE @@FETCH_STATUS = 0
	begin

	--do some work
	set @age = floor( convert(float, getdate()-@dob)/365.25)
	set @totalvalue = (select sum(contractvalue) from tblcontracts where contractclient=@id)

	if @totalvalue >0 and @age is not null
	begin
	insert into #tblresults(clientid, salesvalue,age)
		values(@id, @totalvalue, @age)
	end

	FETCH NEXT FROM MY_cursor
	INTO @id, @dob
	--variables defined above
	end 
CLOSE MY_cursor
   DEALLOCATE MY_cursor
   
select * from #tblresults
