--
select 
row_number() over(order by contractvalue desc, contractsigndate desc) as RowID,
* from tblcontracts

-- Filtering using subQuery
select * from 
	(
	select 
	row_number() over(order by contractvalue desc, contractsigndate desc) as RowID,
	* from tblcontracts
	) as Numbers
where Numbers.RowID <= 10

-- Filtering using with clause
with numbers as 
	(
	select 
	row_number() over(order by contractvalue desc, contractsigndate desc) as RowID,
	* from tblcontracts
	)
-- select * from numbers where RowID <= 10
select top 10 * from numbers order by rowid desc

-- Filtering using subQuery
select * from 
	(
	select 
	rank() over(order by contractvalue desc) as Ranking,
	* from tblcontracts
	) as R
where R.Ranking <= 10

select top 10 * from 
	(
	select 
	rank() over(order by contractvalue desc) as Ranking,
	* from tblcontracts
	) as R
order by ranking desc