select * from tblcontacts

select fn+sn, count(*) from tblcontacts
group by fn+sn
having count(*) > 1

select * from tblcontacts
where fn+sn in(select fn+sn from tblcontacts
group by fn+sn
having count(*) > 1)

select * from tblcontacts A
where exists ( select B.contactid from tblcontacts B
	where B.fn=A.fn
	and B.sn=A.sn
	and B.contactid <> A.contactid)
	
select * from tblcontacts A
where exists ( select B.contactid from tblcontacts B
	where B.fn=A.fn
	and B.sn=A.sn
	and B.contactid < A.contactid)
	