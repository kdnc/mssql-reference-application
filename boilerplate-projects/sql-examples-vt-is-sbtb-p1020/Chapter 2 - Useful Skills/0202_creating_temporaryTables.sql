--Create a Temporary Table
create table #sample(
contactid int,
firstName varchar(100),
lastName varchar(100),
displayName varchar(150),
dob smalldatetime
)

select * from #sample

insert into #sample(contactid, firstName, lastName, dob)
	select contactid, fn, sn, dateOfBirth from tblContacts

update #sample
	set displayName = firstName + ' ' + lastName

delete from #sample 
	where contactid in (5, 6, 7, 9)