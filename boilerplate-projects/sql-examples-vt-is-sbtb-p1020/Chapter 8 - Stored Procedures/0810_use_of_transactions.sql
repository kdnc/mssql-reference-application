-- Use of transactions


-- Create stored procedure which has transactions
create proc dbo.sptestTran
as

begin tran

update tblcontacts
set maritalstatus=3
where maritalstatus is null

if @@error <>0
begin
	rollback tran
	return 3
end

update tblcontacts
set town ='Leeds'
where contactid=37

if @@error <>0
begin
	rollback tran
	return 3
end

update tblcontacts
set town ='Leeds'
where fn='John'

if @@error <>0
begin
	rollback tran
	return 3
end

if @@rowcount =5
begin
	commit tran
end
else
begin
	rollback tran
	return 6
end


-- Execute above stored procedure
exec sptestTran