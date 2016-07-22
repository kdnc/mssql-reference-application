use terra

--largest contract from each year
create view dbo.vwAnnualBestContract
as
	with data as
	(
	select 
	rank() over(partition by contractyear order by contractvalue desc) as ranking,
	* from tblcontracts
	)
	select * from data where ranking=1

select * from vwAnnualBestContract

--top 10 clients of all time
create view dbo.vwTopTenClients 
as
	select * from
	(
		select 
		rank() over( order by sum(contractvalue) desc) as ranking,
		contractclient
		,sum(contractvalue) as Total from tblcontracts
		group by contractclient
	) as D
	where d.ranking <=10

-- Joining the view to a table
select * from dbo.vwTopTenClients T
inner join tblcontacts c
on T.contractClient = c.contactID
order by ranking

-- Joining the view to a table
select * from vwAnnualBestContract B
inner join tblcontracts co
on b.contractclient = co.contractclient
order by co.contractclient