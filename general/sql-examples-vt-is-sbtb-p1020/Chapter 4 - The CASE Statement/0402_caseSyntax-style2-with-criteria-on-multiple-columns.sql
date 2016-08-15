select
	case 
	when criteria then Value
	when anotherCriteria then Value
		
	else
	value
	end
	
	as ColumnName
	
	from TABLENAME

select
	case 
		when gender=1 then 'MALE'
		when gender=2 then 'FEMALE'
		else 'UNDEFINED'
	end as Gender,

	case 
		when country='USA' then 'USA'
		when region='North Yorkshire' then 'USA'
		when right(convert(varchar(200), email), 4)= '.com' then 'USA'
		else 'RestOfWorld'
	end as Country,

* from tblcontacts