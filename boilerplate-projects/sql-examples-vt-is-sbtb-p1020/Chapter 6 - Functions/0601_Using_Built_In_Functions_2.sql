select * from tblcontacts

/*
Deterministic functions 
-always return the same result any time they are called 
with a specific set of input values. 

Nondeterministic functions
- may return different results each time they are called 
with a specific set of input values. 
*/
select pi()as PI
select getdate() as NOW
select pi() * power(3,2)
select left('fred',3)
select power(3,2)
select month(getdate()) as Mth
use terra
select
pi() as PI,
getdate() as nowDate,
left(fn,1) as Initial,
right([zip-postcode],3) as WalkCode,
upper(sn) as UpperCase,
lower(sn) as lowercase,
substring(email,3,10) as MidString, --mid in some SQL 
len(town) as LenTown,
day(dateofbirth) as BirthDay,
month(dateofbirth) as BirthMonth,
year(dateofbirth) as BirthYear,
* from tblcontacts

--aggregate functions
select 
  sum(contractvalue) as TotalContractValue,
avg(contractvalue) as AvgContracts,
count(contractid) as NumberContracts,
max(contractvalue) as highestContractValue,
min(contractvalue) as lowestContractValue
  from tblcontracts

