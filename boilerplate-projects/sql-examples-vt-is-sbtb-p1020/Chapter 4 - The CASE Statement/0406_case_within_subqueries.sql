
create table #DEALS
(dealyear varchar(10), dealSales float, dealWeeks int)

select * from #deals

insert into #deals(dealyear,dealsales,dealweeks)
	select v.conyear,v.convalue,w.conweeks from 
	(select 
		case
			when contractsigndate between '2014-04-01' and '2015-03-31' then '2014/15'
			when contractsigndate between '2013-04-01' and '2014-03-31' then '2013/14'
			when contractsigndate between '2012-04-01' and '2013-03-31' then '2012/13'
			else
			'Pre 2012'
		END as ConYear
		,sum(contractvalue) as ConValue from tblcontracts
		group by 
			(case
			when contractsigndate between '2014-04-01' and '2015-03-31' then '2014/15'
			when contractsigndate between '2013-04-01' and '2014-03-31' then '2013/14'
			when contractsigndate between '2012-04-01' and '2013-03-31' then '2012/13'
			else
			'Pre 2012'
			END)
	) as V
	,
	(select 
		(case
			when weekstartdate between '2014-04-01' and '2015-03-31' then '2014/15'
			when weekstartdate between '2013-04-01' and '2014-03-31' then '2013/14'
			when weekstartdate between '2012-04-01' and '2013-03-31' then '2012/13'
			else
			'Pre 2012'
		END) as conYear
		,count(weekid) as conWeeks from tblweeks
		group by 
			(case
				when weekstartdate between '2014-04-01' and '2015-03-31' then '2014/15'
				when weekstartdate between '2013-04-01' and '2014-03-31' then '2013/14'
				when weekstartdate between '2012-04-01' and '2013-03-31' then '2012/13'
				else
				'Pre 2012'
		END)
	) as W
	where v.conyear = w.conyear
