-- Stored procedures within stored procedure

create proc dbo.spOutputContacts
@contactid int =null
as
set nocount on
if @contactid is not null
begin

declare @exists int
exec @exists = spReturnValue @contactid

	if @exists =1
	begin
	declare @town varchar(50)
	set @town = (select town from tblcontacts where contactid =@contactid)
	
	execute spOutputRecordset @town
	end
	else
	begin
	select * from tblcontacts
	
	end

end


exec spOutputContacts 39