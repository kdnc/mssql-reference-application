--
select 
rank() over(order by sum(contractvalue) desc) as CompanyRanking,
sum(contractvalue) as Sales,
contractyear
from tblcontracts
group by contractyear


select 
rank() over(order by contractvalue desc, contractsigndate desc) as Ranking,
* from tblcontracts

-- Partition by contractYear column, Rank starts from 1 for the next partition
select 
rank() over(partition by contractyear order by contractvalue desc, contractsigndate desc) as Ranking,
* from tblcontracts

-- Partition by region column, Rank starts from 1 for the next partition
select
row_number() over(partition by region order by sn) as Sorted,
region,
* from tblcontacts

