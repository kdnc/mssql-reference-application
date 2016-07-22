select
	case COLUMNNAME
	when value then newValue
	when value then newValue
	
	
	else
	newvalue
	end
	
	as ColumnName
	
	from TABLENAME

select 
	case gender
		when 1 then 'MALE'
		when 2 then 'FEMALE'
		else 'UNDEFINED'
	end as GenderLabel,

	case region	
		when 'teesside' then 'UK'
		when 'north yorkshire' then 'UK'
		when 'tyne and wear' then 'UK'
		else 'USA'
	end as Country,

	case month(dateofbirth)
		when 1 then 'JAN'
		when 2 then 'FEB'
		when 3 then 'MAR'
		when 4 then 'APR'
		when 5 then 'MAY'
		when 6 then 'JUN'
		else 'OTHER'
	end as MonthDOB,
* from tblcontacts