--INSERT
insert into sample(cid,cname,ctown)
	values(1,'Guy Vaccaro', 'Someplace Else')
	
select * from dbo.sample	

--UPDATE

update dbo.sample
set cname='Gaetano Richard Vaccaro'
where cid=1

select * from dbo.sample	

--DELETE
delete from dbo.sample
where cid=1

select * from dbo.sample	
