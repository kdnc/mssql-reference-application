declare @x int

set @x = 100

print @x

declare @y int, @town varchar(100), @sales float

set @town = 'Leeds'

select * from tblcontacts where town = @town

set @sales = (select sum(contractvalue) from tblcontracts)

print @sales