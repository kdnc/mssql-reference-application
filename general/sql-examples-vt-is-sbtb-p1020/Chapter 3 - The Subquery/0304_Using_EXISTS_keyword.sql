-- If there are contacts in 'teeside' region, return all the contracts
select * from tblcontracts 
where exists
(
select * from tblcontacts  where region='teesside' 
)

-- Return the contracts where the contacts of them live in 'teesside' region
select * from tblcontracts c1
where exists
(
select * from tblcontacts c2 where region='teesside' and c1.contractclient=c2.contactid
)

-- Above statement written using in clause
select * from tblcontracts c1
where contractclient in
(select contactid from tblcontacts c2 where region='teesside' )

