------------First example (Writing subQuery for inner join)--------------

-- Select contact details who have given contracts

select contactid, fn, sn, town from tblcontacts co
inner join tblcontracts c
on co.contactid=c.contractclient
group by contactid, fn, sn, town

select * from tblcontacts 
where contactid in(select contractclient from tblcontracts)

------------Second example (Writing subQuery for inner join)--------------

-- Select contracts with the payments
select contractid, contractvalue from tblcontracts c 
inner join tblpayments p
on c.contractid=p.paymentcontract
group by contractid, contractvalue

select * from tblcontracts
where contractid in(select paymentcontract from tblpayments)

------------Third example Complex subQuery--------------

-- Select contracts with the payments due in 2014-2015 financial year
select * from tblcontracts
where contractid in
	(select paymentcontract from tblpayments
	where paymentweek in
		(select weekid from tblweeks where weekyear=6)
	)
