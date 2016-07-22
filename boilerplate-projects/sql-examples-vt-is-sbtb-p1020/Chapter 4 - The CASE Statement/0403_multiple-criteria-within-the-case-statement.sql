select
case
when contractsigndate between '2014-04-01' and '2015-03-31' then '2014/15'
when contractsigndate between '2013-04-01' and '2014-03-31' then '2013/14'
else
'Older Contract'
end as ContractYear
,
case 
when (select count(*) from tblcontracts b where b.contractclient=a.contractclient) >10
	then 'Large'
	else 'Small'
	end as 'Client Size'
,*
from tblcontracts a

---

select 
case 
when gender=1 and maritalstatus=1 then 'Unmarried Male'
when gender=2 and maritalstatus=2 then 'Married Female'
when gender=1 and maritalstatus=2 then 'Married Male'
else 'Undefined' end as Maritalstatus,
* from tblcontacts
