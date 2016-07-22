-- Find top selling person for each region using subquery

select * from
(
select 
rank() over (partition by c.region order by sum(co.contractvalue) desc) as Position ,
c.contactid, c.fn, c.sn, c.region, sum(co.contractvalue) as Sales
from tblcontacts c
inner join tblcontracts co
on c.contactid=co.contractclient
group by c.contactid, c.fn, c.sn, c.region
) as N
where N.Position=1

-- Find top selling person for each region using with clause
with topclient as
(
select 
rank() over (partition by c.region order by sum(co.contractvalue) desc) as Position ,
c.contactid, c.fn, c.sn, c.region, sum(co.contractvalue) as Sales
from tblcontacts c
inner join tblcontracts co
on c.contactid=co.contractclient
group by c.contactid, c.fn, c.sn, c.region
) 
--select * from topclient where Position=1
-- Find top selling person for top 10 regions using with clause
select top 10 * from topclient order by Position, sales desc