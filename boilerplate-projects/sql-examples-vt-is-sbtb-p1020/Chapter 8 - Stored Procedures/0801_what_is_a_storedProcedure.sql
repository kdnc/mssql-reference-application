use terra
go

-- Method 1 - Create a stored procedure using output keyword

create proc dbo.spOutputParamTest
@contactid int =null,
@age float output
as
set nocount on
if @contactid is not null
begin
set @age = (select convert(float,(getdate()-dateofbirth))/365.25 from tblcontacts where contactid=@contactid)

end

-- Executing spOutputParamTest stored procedure

declare @thisage float
execute spOutputParamTest @contactid=46, @age=@thisage output
print @thisage

--

-- Method 2 - Create a stored procedure using return value

create proc dbo.spReturnValue
@contactid int =null
as
set nocount on
if @contactid is not null
begin
declare @countContact int
set @countContact =(select count(*) from tblcontacts where contactid=@contactid )

return @countContact
end

-- Executing spReturnValue stored procedure

declare @retval int
exec @retval =   spReturnValue 15
print @retval


-- Method 3 - Create a stored procedure to output a record set

create proc dbo.spOutputRecordset
@city varchar(50) =null
as
set nocount on
if @city is not null
begin
select * from tblcontacts where town=@city

end

-- Executing spOutputRecordset stored procedure

execute spOutputRecordset 'leeds'