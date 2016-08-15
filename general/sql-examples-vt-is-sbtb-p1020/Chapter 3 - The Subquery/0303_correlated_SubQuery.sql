-- Correlated subquery is the one that is linked to the outer query it is being used in

-- How many payments due for the each of the contracts
select *
,(select count(paymentid) from tblpayments where paymentcontract=contractid) as Payments
from tblcontracts

-- Select the total contract value for each contract client and select the total annual contract value for each contract's year

select *
,(select sum(contractvalue) from tblcontracts c2 where c1.contractclient=c2.contractclient) as ClientTotal
,(select sum(contractvalue) from tblcontracts c2 where year(c1.contractsigndate)=year(c2.contractsigndate)) as AnnualTotal
from tblcontracts c1


--
