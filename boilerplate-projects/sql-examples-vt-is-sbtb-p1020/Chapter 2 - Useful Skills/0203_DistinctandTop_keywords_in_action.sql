--DISTINCT = unique entries
--TOP x = The Top x of records

select distinct town from tblContacts;

select count(*), count(distinct paymentContract) from tblPayments;

select top 10 * from tblContacts order by dateofbirth desc;

select top 8 with ties sum(paymentAmount) as Payments, paymentContract 
from tblPayments
group by paymentContract
order by sum(paymentAmount) desc;