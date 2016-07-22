/*
Deterministic functions 
-always return the same result any time they are called 
with a specific set of input values. 

Nondeterministic functions
- may return different results each time they are called 
with a specific set of input values. 
*/

-- Deterministic function
select pi() as PI

-- NonDeterministic function
select getdate() as TODAY

-- Function with input parameters
select left('me and my dog', 4) as LeftCol

-- Function inside a function
select month(getdate()) as Mth

-- More uses of functions
select left(fn, 1) as Initial,
upper(sn) as LastName,
day(dateofbirth) as Birthday,
month(dateofbirth) as BirthMonth
from tblcontacts

-- IsNull function
select left(fn, 1) as Initial,
upper(sn) as LastName,
isnull(day(dateofbirth), 0) as Birthday,
isnull(month(dateofbirth), 0) as BirthMonth
from tblcontacts