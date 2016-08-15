--

select 
row_number() over(order by contractvalue desc) as RowID,
* from tblcontracts

select 
row_number() over(order by contractvalue desc, contractsigndate desc) as RowID,
* from tblcontracts

select 
row_number() over(order by contractvalue desc) as RowID,
* from tblcontracts
order by contractclient

select 
rank() over(order by contractvalue desc) as Ranking,
* from tblcontracts

select 
rank() over(order by contractvalue desc, contractsigndate desc) as Ranking,
* from tblcontracts



--
select * from tblcontacts