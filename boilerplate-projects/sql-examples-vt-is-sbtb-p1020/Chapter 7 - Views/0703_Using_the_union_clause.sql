-- Union takes first record set and appends the second record set
-- Both record sets should have the same number of columns and same data tpes in each column
create view dbo.vwUnionContractStats
as
	select c.contactid, c.fn as Firstname, c.sn as Lastname, b.contractValue, b.ranking, b.contractYear
	from dbo.vwAnnualBestContract b
	inner join tblcontacts c
	on b.contractClient = c.contactID

	union

	select c.contactid, c.fn, c.sn, t.total, t.ranking, 'NA' as cyear
	from dbo.vwTopTenClients T
	inner join tblcontacts c
	on c.contactid = t.contractclient

select * from dbo.vwUnionContractStats
order by contractvalue desc