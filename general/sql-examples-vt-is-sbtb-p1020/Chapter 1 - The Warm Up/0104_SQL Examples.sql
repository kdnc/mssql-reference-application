select * from tblcontacts

select fn, sn, town from tblcontacts

select fn, sn, town, region from tblcontacts 
order by region

select fn, sn, town from tblcontacts 
where region ='West Yorkshire'


select Region, count(contactid) as Contacts  from tblcontacts
group by Region
having count(contactid)>2
order by count(contactid) desc

select fn, sn, M.MaritalStatus from tblcontacts C
inner join tblMaritalStatus M
on C.maritalstatus=m.maritalstatusid

select sum(paymentAmount) as Total, month(w.weekstartdate)as MonthNo from tblPayments P
inner join tblWeeks w
on P.paymentweek=w.weekid
where w.weekstartdate between '2014-01-01' and '2014-06-30'
group by month(w.weekstartdate)