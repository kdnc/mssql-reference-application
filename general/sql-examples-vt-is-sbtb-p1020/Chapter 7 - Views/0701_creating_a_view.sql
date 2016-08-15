-- Syntax
CREATE viewName
AS
select statement

-- Create view
create view dbo.vwClientContracts
as 
select c.contactid, c.fn, c.sn, c.region, co.contractid from tblcontacts c
inner join tblcontracts co
on c.contactid=co.contractclient

-- Query the view
select * from vwClientContracts

-- Alter view
alter view dbo.vwClientContracts
as 
select c.contactid, c.fn, c.sn, c.region, co.contractid from tblcontacts c
inner join tblcontracts co
on c.contactid=co.contractclient
where c.region='north yorkshire'

-- Query the view
select * from vwClientContracts