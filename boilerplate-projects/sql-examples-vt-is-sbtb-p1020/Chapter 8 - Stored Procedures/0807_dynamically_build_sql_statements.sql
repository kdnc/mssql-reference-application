-- Dynamically build sql statements

-- Version which needs to escape the ' delimiter in @town
declare @sql varchar(1000), @columns varchar(500), @town varchar(50), @table varchar(100)

set @columns = 'fn, sn, email, town, dateofbirth'
set @table='tblcontacts'
set @town='''Northallerton'''
set @sql ='Select ' + @columns + ' from ' + @table + ' where town =' + @town

print @sql
exec(@sql)


-- Version which does not need to escape the ' delimiter in @town
declare @sql nvarchar(1000), @columns varchar(500), @town varchar(50), @table varchar(100)

set @columns = 'fn, sn, email, town, dateofbirth'
set @table='tblcontacts'
set @town='Northallerton'
set @sql ='Select ' + @columns + ' from ' + @table + ' where town =@city' 

execute sp_executesql @sql, N'@city varchar(50)', @city = @town
