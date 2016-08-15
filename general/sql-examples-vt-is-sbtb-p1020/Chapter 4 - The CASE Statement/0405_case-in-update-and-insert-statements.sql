select 
	case
		when contractsigndate between '2014-04-01' and '2015-03-31' then '2014/15'
		when contractsigndate between '2013-04-01' and '2014-03-31' then '2013/14'
		when contractsigndate between '2012-04-01' and '2013-03-31' then '2012/13'
		else
		'Older Contract'
	END as ContractYear
,* from tblcontracts

--

update tblcontracts
set contractYear = 
	(case
		when contractsigndate between '2014-04-01' and '2015-03-31' then '2014/15'
		when contractsigndate between '2013-04-01' and '2014-03-31' then '2013/14'
		when contractsigndate between '2012-04-01' and '2013-03-31' then '2012/13'
		else
		'Pre 2012'
	END)

--

create table #DEALS
(dealyear varchar(10), dealSales float, dealWeeks int)

insert into #deals(dealyear, dealsales)
	select 
		case
			when contractsigndate between '2014-04-01' and '2015-03-31' then '2014/15'
			when contractsigndate between '2013-04-01' and '2014-03-31' then '2013/14'
			when contractsigndate between '2012-04-01' and '2013-03-31' then '2012/13'
			else
			'Pre 2012'
		END
		,sum(contractvalue) from tblcontracts
	group by 
		(case
			when contractsigndate between '2014-04-01' and '2015-03-31' then '2014/15'
			when contractsigndate between '2013-04-01' and '2014-03-31' then '2013/14'
			when contractsigndate between '2012-04-01' and '2013-03-31' then '2012/13'
			else
			'Pre 2012'
		END)

select * from #deals

--

select 
	case
		when contractsigndate between '2014-04-01' and '2015-03-31' then '2014/15'
		when contractsigndate between '2013-04-01' and '2014-03-31' then '2013/14'
		when contractsigndate between '2012-04-01' and '2013-03-31' then '2012/13'
		else
		'Pre 2012'
	END
,sum(contractvalue) from tblcontracts
group by 
	(case
		when contractsigndate between '2014-04-01' and '2015-03-31' then '2014/15'
		when contractsigndate between '2013-04-01' and '2014-03-31' then '2013/14'
		when contractsigndate between '2012-04-01' and '2013-03-31' then '2012/13'
		else
		'Pre 2012'
	END)


select 
	(case
		when weekstartdate between '2014-04-01' and '2015-03-31' then '2014/15'
		when weekstartdate between '2013-04-01' and '2014-03-31' then '2013/14'
		when weekstartdate between '2012-04-01' and '2013-03-31' then '2012/13'
		else
		'Pre 2012'
	END)
,count(weekid) from tblweeks
group by 
	(case
		when weekstartdate between '2014-04-01' and '2015-03-31' then '2014/15'
		when weekstartdate between '2013-04-01' and '2014-03-31' then '2013/14'
		when weekstartdate between '2012-04-01' and '2013-03-31' then '2012/13'
		else
		'Pre 2012'
	END)