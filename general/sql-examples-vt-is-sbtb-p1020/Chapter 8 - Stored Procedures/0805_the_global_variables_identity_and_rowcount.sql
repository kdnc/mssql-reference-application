-- @@rowcount - Number of rows affected with the last statement ran
select * from tblcontacts
print @@rowcount

select * from tblcontacts where town='leeds'
print @@rowcount

update tblcontacts set line2='No Line2' where town='Leeds' and line2 is null
print @@rowcount


-- @@identity - Value of the identity column most recently created

insert into tblcontacts(fn,sn,house,street,town,region,[zip-postcode],
	country,telephone,cell,email)
values('Ann','Welcome','42','High Street','Leeds','West Yorkshire','LS7 7YY',
	'UK','555 9854', '555 6412','ann@welcome.com')
	
print @@identity
		
-- Example using @@identity in stored procedure
create proc dbo.spInsertContactwithContract
@fn varchar(50) =null,
@sn varchar(50) =null,
@house varchar(250) =null,
@street varchar(250) =null,
@town varchar(250) =null,
@region varchar(250) =null,
@zip varchar(15) =null,
@country varchar(250) =null,
@telephone varchar(250) =null,
@cell varchar(250) =null,
@email varchar(250) =null,
@value float =null
as
set nocount on

insert into tblcontacts(fn,sn,house,street,town,region,[zip-postcode],
	country,telephone,cell,email)
values(@fn,@sn,@house,@street,@town,@region,@zip,
	@country,@telephone,@cell,@email)		

declare @newID int
set @newID = @@identity

insert into tblcontracts(contractclient, contractvalue, contractsigndate)
	values(	@newID, @value, getdate())
	