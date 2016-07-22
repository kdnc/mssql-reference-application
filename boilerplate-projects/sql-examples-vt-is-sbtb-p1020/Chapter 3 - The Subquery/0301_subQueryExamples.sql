select (select sum(contractvalue) from tblcontracts) as Sales,* from tblcontacts

select (select count(childid) from tblchildren where childparent=contactid) as Children,
* from tblcontacts

select (select count(contactid) from tblcontacts CO where CO.region =c.region) as ComPats
,* from tblcontacts c


select * from tblcontacts
where contactid in(select contractclient from tblcontracts where contractvalue >5000)


select * from tblcontacts
where contactid in(select contractclient from tblcontracts where contractvalue >5000)
and region in(select region from tblcontacts group by region having count(contactid) >30 )

