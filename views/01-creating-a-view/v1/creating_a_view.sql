-- Syntax
CREATE VIEW viewName
AS
SELECT statement

-- Create view
create view dbo.vwClientContracts
as 
	select c.contactid, c.fn, c.sn, c.region, co.contractid from tblcontacts c
	inner join tblcontracts co
	on c.contactid=co.contractclient
